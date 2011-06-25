module Crisp
  module Functions
    # require all files that are defining functions
    require 'crisp/functions/core'
    require 'crisp/functions/arithmetic'
    require 'crisp/functions/array'
    require 'crisp/functions/sequence'

    # Load all defined function to the given environment
    def self.load(env)
      Core.load(env)
      Arithmetic.load(env)
      Array.load(env)
      Sequence.load(env)
    end
  end
end
