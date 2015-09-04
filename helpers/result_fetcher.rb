require 'active_record'
require_relative '../models/capability'
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
      puts result
      capability.last_result = result
      capability.save
    end
  end

  def add(capability)
    return if @to_do[capability.id]
    @to_do[capability.id] = capability
    internal_runner
  end
end
