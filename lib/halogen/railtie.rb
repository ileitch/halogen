module Halogen
  class Railtie < Rails::Railtie
    config.before_initialize do
      Coverage.start
    end

    config.after_initialize do
      Coverage.result(:retain => true)
    end
  end
end
