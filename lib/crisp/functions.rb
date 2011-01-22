module Crisp
  module Functions
    # require all files that are defining functions
    require 'crisp/functions/core'
    require 'crisp/functions/arithmetic'
    require 'crisp/functions/array'

    # Load all defined function to the given environment
    def self.load(env)
      Core.load(env)
      Arithmetic.load(env)
      Array.load(env)
    end
  end
end
