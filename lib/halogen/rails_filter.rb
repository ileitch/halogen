module Halogen
  module RailsFilter
    def self.included(base)
      return unless Halogen.enabled

      base.class_eval do
        prepend_around_filter :halogen_cover
      end
    end

    protected

    def halogen_cover
      seq = Halogen.increment_sequence
      if seq % Halogen.config.frequency == 0
        Coverage.start(Halogen.covered_files)
        begin
          yield
        ensure
          result = Coverage.result(:retain => true)
          Halogen.dispatch(result, seq / Halogen.config.frequency)
        end
      else
        yield
      end
    end
  end
end
