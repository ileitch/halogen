require 'coverage'

require 'halogen/version'
require 'halogen/configuration'
require 'halogen/dispatcher'
require 'halogen/dispatcher/resque'
require 'halogen/dispatcher/thread'

if defined? Rails
  require 'halogen/railtie'
  require 'halogen/rails_filter'
end

module Halogen
  attr_accessor :enabled

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

  def self.dispatch(result)
    begin
      dispatcher.dispatch(result)
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

  def self.reset_sequence
    Thread.exclusive do
      @sequence = 0
    end
  end

  def self.ensure_compatability
    if Coverage.method(:result).arity == 0
      Rails.logger.error("Your Ruby version does not support retaining coverage results. Halogen is disabled.")
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
