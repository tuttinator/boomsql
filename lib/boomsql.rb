require "boomsql/version"
require 'tiny_tds'
require 'yaml'
require 'json'
require 'json/ext'

module Boomsql
  
  class Executor

    attr_accessor :filename, :query
    attr_reader   :last_query

    def initialize(credentials, options = {}, query = nil)
      @client = TinyTds::Client.new(credentials)
      # sanitize the format option into
      @format = options[:format].downcase.to_sym if options[:format].present?
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
