module Halogen
  module Dispatcher
    class Resque
      def dispatch(result)
        Resque.enqueue(Halogen::ResultJob, result)
      end
    end
  end
end
