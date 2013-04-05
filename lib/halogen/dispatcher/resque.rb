module Halogen
  module Dispatcher
    class Resque
      def dispatch(result, run_count)
        Resque.enqueue(Halogen::ResultJob, result, run_count)
      end
    end
  end
end
