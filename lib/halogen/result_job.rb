module Halogen
  class ResultJob
    def self.perform(result)
      begin
        SimpleCov.configure do
          merge_timeout 1.week
          root File.dirname(Halogen.config.coverage_path)
          coverage_dir File.basename(Halogen.config.coverage_path)
          formatter SimpleCov::Formatter::HTMLFormatter
        end

        sc_result = SimpleCov::Result.new(result)
        SimpleCov::ResultMerger.store_result(sc_result)
        SimpleCov::ResultMerger.merged_result.format!
      rescue StandardError => e
        Rails.logger.error(e.inspect)
        Rails.logger.error(e.backtrace.join("\n"))
      end
    end
  end
end
