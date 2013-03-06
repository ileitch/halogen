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
      if Halogen.increment_sequence >= Halogen.config.frequency
        Halogen.reset_sequence
        Coverage.start
        begin
          yield
        ensure
          result = Coverage.result(:retain => true)
          Halogen.dispatch(result)
        end
      else
        yield
      end
    end
  end
end
