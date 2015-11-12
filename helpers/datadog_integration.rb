require 'dogapi'
require "net/http"
require "uri"

class DatadogMetric
  def initialize(from_time, to_time, query)
    api_key=ENV['DATADOG_API_KEY']
    app_key=ENV['DATADOG_APP_KEY']
    params = {api_key: api_key, application_key: app_key, from: from_time, to: to_time, query: query}
    uri = URI.parse("https://app.datadoghq.com/api/v1/query")
    uri.query = URI.encode_www_form(params)
    @response = Net::HTTP.get(uri)
  end

  def result
    @response
  end
end

class DatadogEvent
  def initialize(start_time, end_time, sources)
    api_key=IO.readlines(File.dirname(__FILE__) + "/../datadog_keys.txt")[0].chomp
    app_key=IO.readlines(File.dirname(__FILE__) + "/../datadog_keys.txt")[1].chomp
    params = {api_key: api_key, application_key: app_key, start: start_time, end: end_time, sources: sources}
    uri = URI.parse("https://app.datadoghq.com/api/v1/events")
    uri.query = URI.encode_www_form(params)
    @response = Net::HTTP.get(uri)
  end

  def result
    @response
  end
end
