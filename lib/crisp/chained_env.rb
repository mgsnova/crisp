module Crisp
  # The ChainedEnv combines to given environments.
  # This is useful to combine a global and a local environment for easy access
  #
  class ChainedEnv
    # creates new chained env with given envs
    # It is used that the 'first' is the local and the 'second' the global env
    def initialize(first, second)
      @first = first
      @second = second
    end

    # Read access is performed preferred on the 'first' env.
    # If the 'first' env is not holding a value for the key, the 'second' will be requested.
    def [](key)
      if @first.has_key?(key)
        @first[key]
      else
        @second[key]
      end
    end

    # Storing a value for a key will always be performed on the 'second' env.
    def []=(key, val)
      @second[key] = val
    end
  end
end
