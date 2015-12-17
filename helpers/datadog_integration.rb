require 'dogapi'
require "net/http"
require "uri"

class DatadogMetric
  def initialize(from_time, query)
    api_key=ENV['DATADOG_API_KEY']
    app_key=ENV['DATADOG_APP_KEY']
    t = Time.now.to_i - (start_time.to_i * 86400)
    params = {api_key: api_key, application_key: app_key, from: t, to: Time.now.to_i, query: query}
    uri = URI.parse("https://app.datadoghq.com/api/v1/query")
    uri.query = URI.encode_www_form(params)
    @response = Net::HTTP.get(uri)
  end

  def result
    @response
  end
end

class DatadogEvent
  def initialize(start_time, sources, tags)
    api_key=ENV['DATADOG_API_KEY']
    app_key=ENV['DATADOG_APP_KEY']
    t = Time.now.to_i-(start_time.to_i * 86400)
    params = {api_key: api_key, application_key: app_key, start: t, end: Time.now.to_i, sources: sources, tags: tags}.delete_if{ |key,val| val.to_s.strip.empty? }
    uri = URI.parse("https://app.datadoghq.com/api/v1/events")
    uri.query = URI.encode_www_form(params)
    @response = Net::HTTP.get(uri)
  end

  def result
    @response
  end
end
