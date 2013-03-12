module Halogen
  module Dispatcher
    class Thread
      def dispatch(result)
        ::Thread.new do
          Halogen::ResultJob.perform(result)
        end
      end
    end
  end
end
