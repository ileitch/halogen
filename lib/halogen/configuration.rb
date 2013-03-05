module Halogen
  class Configuration < Struct.new(:frequency, :dispatcher, :coverage_path,
    :initial_sequence)

    def initialize
      super
      set_defaults
    end

    def set_defaults
      self.coverage_path = "/tmp/halogen_#{Rails.env}_coverage"
      self.frequency = 500
      self.dispatcher = :resque
      self.initial_sequence = 0
    end
  end
end
