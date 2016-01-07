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

  def fetch(capability)
    case capability.integration
      when "jenkins"
        result = Faraday.get(capability.url)
        200 == result.status ? result.body : result.status
      when "jira"
        $access_token.get(capability.url).body
      when "dd_event"
        DatadogEvent.new(capability.dd_length, capability.url, capability.dd_tags).result
      when "dd_metric"
        DatadogMetric.new(capability.dd_length, capability.url).result
    end
  rescue => e
  end

  def internal_runner
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
      capability.last_result = result
      capability.save
      check_result(capability)
    end
  end

  def run
    @to_do.clear
    ActiveRecord::Base.connection_pool.with_connection do
      Capability.all.each do |capability|
        @to_do[capability.id] = capability unless @to_do[capability.id]
      end
      internal_runner
    end
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
