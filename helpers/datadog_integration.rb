require 'dogapi'
require "net/http"
require "uri"

class DatadogMetric
  def initialize(from_time, to_time, query)
    api_key=IO.readlines(File.dirname(__FILE__) + "/../datadog_keys.txt")[0].chomp
    app_key=IO.readlines(File.dirname(__FILE__) + "/../datadog_keys.txt")[1].chomp
    params = {api_key: api_key, application_key: app_key, from: from_time, to: to_time, query: query}
    uri = URI.parse("https://app.datadoghq.com/api/v1/query")
    uri.query = URI.encode_www_form(params)
    @response = Net::HTTP.get(uri)
  end

  def result
    @response
  end
end

# metric = DatadogMetric.new(Time.now.to_i - 604800, Time.now.to_i, "avg:mongo_query.avg{mongo_op:find} by {mongo_collection} * sum:mongo_query.count{mongo_op:find} by {mongo_collection}.as_rate()")
# puts metric.result

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
# 
# event= DatadogEvent.new(Time.now.to_i - 604800, Time.now.to_i, "pingdom")
# puts event.result
