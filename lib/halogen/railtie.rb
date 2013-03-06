module Halogen
  class Railtie < Rails::Railtie
    config.before_eager_load do
      Coverage.start
    end

    config.after_eager_load do
      Coverage.result(:retain => true)
    end
  end
end
