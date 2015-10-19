require 'active_record'
require_relative '../models/capability'
require_relative '../models/result'
require 'faraday'
require 'execjs'

class ResultFetcher

  def initialize
    @to_do = {}
  end

  def fetch(url)
    result = Faraday.get(url)
    200 == result.status ? result.body : result.status
  rescue => e
    e
  end

  def run
    Capability.all.each do |capability|
      @to_do[capability.id] = capability unless @to_do[capability.id]
    end
    internal_runner
  end

  def internal_runner
    @to_do.each do |id, capability|
      test_result = fetch(capability.url)
      result = ""
      begin
        result = ExecJS.eval("#{test_result}#{capability.code}")
      rescue => e
         puts e
         result = false
      end
      capability.last_result = result
      capability.save
      check_result(capability)
    end
  end

  def add(capability)
    return if @to_do[capability.id]
    @to_do[capability.id] = capability
    internal_runner
  end

  def check_result (capability)
    time = Time.now.getutc
    check = Result.where(capability_id: capability.id).order(time_start: :desc).first
    if !check
      puts "CREATING NEW RESULT"
      new_result = Result.new(capability_id: capability.id, project_id: capability.project_id, time_start: time, result: capability.last_result)
      new_result.save
    elsif  check.result != capability.last_result
      puts "UPDATING RESULTS HISTORY"
      check.time_end = time
      check.save
      new_result = Result.new(capability_id: capability.id, project_id: capability.project_id, time_start: time, result: capability.last_result)
      new_result.save
    end
  end
end
