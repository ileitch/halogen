module Halogen
  class Railtie < Rails::Railtie
    config.before_initialize do |app|

      if Halogen.enabled
        # TODO: Need a way to disable for certain ... hosts?
        # TODO: ensure cache_classes enabled.

        Halogen.covered_files = app.config.eager_load_paths.map do |load_path|
          Dir.glob("#{load_path}/**/*.rb").sort
        end.flatten

        Coverage.start(Halogen.covered_files)
      end
    end

    config.after_initialize do
      if Halogen.enabled
        result = Coverage.result(:retain => true)
        Halogen.dispatch(result, 0)
      end
    end
  end
end
