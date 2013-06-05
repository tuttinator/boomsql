module Boomsql
  
  class Executor

    attr_accessor :filename, :query
    attr_reader   :last_query, :client

    def initialize(options = {}, query = nil)
      @client = get_client(options[:tiny_tds], options[:ssh_credentials])
      # sanitize the format option into
      @format = options[:format].downcase.to_sym unless options[:format].nil?
      @filename = options[:filename]
      @query = query
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

    def get_client(sql_credentials, ssh_credentials)
      begin
        TinyTds::Client.new(sql_credentials)
      rescue Exception => e
        DatabaseProxy.new(ssh_credentials, e)
      end

    end

    def execute_query!
      @query ||= File.read(@filename)
      result = @client.execute query
      @last_query = @query
      @query = nil

      rows = []
      # FreeTDS lazily executes when #each is called
      result.each {|r| rows << r}
    end

  end

end