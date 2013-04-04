module Halogen
  class Railtie < Rails::Railtie
    config.before_initialize do
      Coverage.start if Halogen.enabled
    end

    config.after_initialize do
      if Halogen.enabled
        result = Coverage.result(:retain => true)
        Halogen.dispatch(result)
      end
    end
  end
end
