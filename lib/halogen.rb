require 'coverage'
require 'simplecov/no_defaults'
require 'simplecov-html'

require 'halogen/version'
require 'halogen/configuration'
require 'halogen/result_job'
require 'halogen/dispatcher'
require 'halogen/dispatcher/resque'
require 'halogen/dispatcher/thread'

if defined? Rails::Railtie
  require 'halogen/railtie'
  require 'halogen/rails_filter'
end

module Halogen
  class << self
    attr_accessor :enabled, :covered_files
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

  def self.dispatch(result, run_count)
    begin
      dispatcher.dispatch(result, run_count)
    rescue StandardError => e
      Rails.logger.error(e)
      Rails.logger.error(e.backtrace.join("\n"))
    end
  end

  def self.increment_sequence
    Thread.exclusive do
      @sequence ||= config.initial_sequence
      @sequence += 1
    end
  end

  def self.check_compatability
    if Coverage.method(:result).arity == 0
      STDERR.puts("Your Ruby version does not support retaining coverage results. Halogen is disabled.")
      Halogen.enabled = false
    end
  end

  private

  def self.dispatcher
    @dispatcher ||= Halogen::Dispatcher.init(config.dispatcher)
  end
end

Halogen.enabled = true
Halogen.check_compatability
