module Halogen
  module Dispatcher
    class Thread
      def dispatch(result, run_count)
        ::Thread.new do
          Halogen::ResultJob.perform(result, run_count)
        end
      end
    end
  end
end
