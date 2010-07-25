require 'crisp/functions/core'
require 'crisp/functions/arithmetic'

module Crisp
  module Functions
    def self.load(env)
      Core.load(env)
      Arithmetic.load(env)
    end
  end
end
