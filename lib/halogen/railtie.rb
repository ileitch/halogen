module Halogen
  class Railtie < Rails::Railtie
    config.before_eager_load do
      Coverage.start
    end

    config.before_initialize do
      Coverage.result(:retain => true)
    end
  end
end
