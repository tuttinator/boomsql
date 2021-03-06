module Boomsql
  
  class Executor

    attr_accessor :filename, :query, :format
    attr_reader   :last_query, :last_result, :client

    def initialize(options = {}, query = nil)
      @client = get_client(options[:boomsql_config])
      # sanitize the format option into
      @format = options[:format].downcase.to_sym unless options[:format].nil?
      @filename = options[:filename]
      @query = query
    end

    def extract_query_from_file!
      if @filename
        # TODO: should we lint the SQL?
        @query = File.read(get_file_path)
      else
        false
      end
    end

    def process!
      result = execute_query!
      case format
      when :yaml # CLI app's default preference
        YAML::dump result
      when :json
        JSON.generate result
      else # ruby object when format not explictly defined
        result
      end
    end

    private

    def get_client(options)

      if options[:tiny_tds].nil?
        DatabaseProxy.new(options[:ssh])
      else        
        begin
          TinyTds::Client.new(options[:tiny_tds])
        rescue Exception => e
          DatabaseProxy.new(options[:ssh])
        end
      end

    end

    def execute_query!
      @query ||= File.read(get_file_path)
      result = @client.execute query
      @last_query = @query

      @query = nil
      rows = []
      # TODO: Implement logging!
      # debug(result)
      # FreeTDS lazily executes when #each is called
      result.each {|r| rows << r}
    end

    def get_file_path
      file_path = search_paths_for(Pathname.new(@filename))
      if file_path.exist?
        file_path
      else
        raise "I can't find your file at #{file_path}, fool!"
      end
    end

    def search_paths_for(file_path)
      return file_path if file_path.exist?

      paths = ENV['PATH'].split(File::PATH_SEPARATOR)
      # Also include whatever the current path is
      paths << `pwd`.chomp
      paths.each do |path|
        @filename = Pathname.new("#{path}#{Pathname::SEPARATOR_LIST}#{file_path}")
        break if @filename.exist?
        @filename = nil
      end
      @filename
    end

  end

end