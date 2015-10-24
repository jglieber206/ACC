require 'active_record'
require_relative '../models/capability'
require_relative '../models/result'
require 'faraday'
require './helpers/jira_integration'
require './helpers/datadog_integration'
require 'json'

class ResultFetcher

  def initialize
    @to_do = {}
  end

  def add(capability)
    return if @to_do[capability.id]
    @to_do[capability.id] = capability
    puts @to_do
    internal_runner
  end

  def fetch(capability)
    if capability.integration == "jenkins"
      puts "***** FETCHING FROM JENKINS ********"
      result = Faraday.get(capability.url)
      200 == result.status ? result.body : result.status
    elsif capability.integration == "jira"
      puts "***** FETCHING FROM JIRA********"
      $access_token.get(capability.url).body
    elsif capability.integration == "dd_event"
      puts "***** FETCHING FROM DD EVENTS********"
      DatadogEvent.new(Time.now.to_i - 604800, Time.now.to_i, capability.url).result
    elsif capability.integration == "dd_metric"
      puts "***** FETCHING FROM DD METRICS********"
      DatadogMetric.new(Time.now.to_i - 3600, Time.now.to_i, capability.url).result
    end
  rescue => e
  end

  def internal_runner
    puts @to_do
    @to_do.each do |id, capability|
      test_result = fetch(capability)
      result = ""
      begin
        result_hash = JSON.parse(%Q{ #{test_result} })
        capability_code = %Q{ #{capability.code} }
        result = eval("#{result_hash}#{capability_code}")
      rescue => e
         result = false
      end
      puts result
      capability.last_result = result
      capability.save
      check_result(capability)
    end
  end

  def run
    Capability.all.each do |capability|
      @to_do[capability.id] = capability unless @to_do[capability.id]
    end
    internal_runner
  end

  def check_result (capability)
    time = Time.now.getutc
    check = Result.where(capability_id: capability.id).order(time_start: :desc).first
    if !check
      new_result = Result.new(capability_id: capability.id, project_id: capability.project_id, time_start: time, result: capability.last_result)
      new_result.save
    elsif  check.result != capability.last_result
      check.time_end = time
      check.save
      new_result = Result.new(capability_id: capability.id, project_id: capability.project_id, time_start: time, result: capability.last_result)
      new_result.save
    end
  end
end
