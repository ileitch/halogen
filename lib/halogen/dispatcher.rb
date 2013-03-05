module Halogen
  module Dispatcher
    def self.init(name)
      const_get(name.titleize).new
    end
  end
end
