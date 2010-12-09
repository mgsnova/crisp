module Crisp
  module Functions
    require 'crisp/functions/core'
    require 'crisp/functions/arithmetic'

    def self.load(env)
      Core.load(env)
      Arithmetic.load(env)
    end
  end
end
