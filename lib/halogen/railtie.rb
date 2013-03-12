module Halogen
  class Railtie < Rails::Railtie
    config.before_initialize do
      Coverage.start
    end

    config.after_initialize do
      result = Coverage.result(:retain => true)
      Halogen.dispatch(result)
    end
  end
end
