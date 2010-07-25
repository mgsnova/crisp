require 'crisp/functions/arithmetic'

module Crisp
  module Functions
    def self.load(env)
      Arithmetic.load(env)
    end
  end
end
