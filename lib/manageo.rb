require 'excon'
require 'json'

require 'manageo/version'
require 'manageo/company'
require 'manageo/subscription'

module Manageo
  class Error < StandardError; end
  class NotFound < StandardError; end

  def default_url
    'https://api.manageo.com'
  end

  def env_url
    ENV['MANAGEO_URL']
  end

  def url
    @url ||= env_url || default_url
  end

  def url=(new_url)
    @url = new_url
  end

  def env_key
    ENV['MANAGEO_KEY']
  end

  def key
    @key ||= env_key
  end

  def key=(new_key)
    @key = new_key
  end

  def connection
    @connection ||= Excon.new(url, headers: {'Ocp-Apim-Subscription-Key' => key})
  end

  def get(path, params = {})
    response = connection.get(path: File.join('mcompany-api', path))

    case response.status
    when 200, 201
      parse_response response
    when 404
      raise NotFound
    else
      raise "Manageo API returned #{response.status} with #{response.body}"
    end

  end

  def parse_response(response)
    parsed = JSON.parse(response.body)

    case parsed
    when Array
      parsed.collect { |item| OpenStruct.new item }
    when Hash
      if parsed.length == 1
        parsed.values.first
      else
        OpenStruct.new parsed
      end
    end
  end

  module_function :default_url, :env_url, :url, :url=,
                  :env_key, :key, :key=,
                  :connection, :get, :parse_response
end
