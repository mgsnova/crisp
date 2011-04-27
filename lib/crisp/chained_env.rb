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

    # Returns boolean for existence of given key in one of the environments.
    def has_key?(key)
      @first.has_key?(key) or @second.has_key?(key)
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

    # returns global loop data of global/second env
    def global_loop_data
      @second.global_loop_data
    end

    # set global loop data to global/second env
    def global_loop_data=(data)
      @second.global_loop_data = data
    end

    # set alias to global/second env
    def alias(to, from)
      @second.alias(to, from)
    end
  end
end
