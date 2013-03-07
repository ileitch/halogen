module Halogen
  module Dispatcher
    def self.init(name)
      const_get(name.to_s.titleize).new
    end
  end
end
