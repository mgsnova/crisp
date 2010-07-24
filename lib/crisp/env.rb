module Crisp
  class Env
    attr_accessor :last_return

    def initialize
      @last_return = nil
    end
  end
end
