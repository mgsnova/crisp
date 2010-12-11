module Crisp
  # The Crisp environment is basically a key/value store.
  # The value for each key is immutable, so you can only store one time for each key
  class Env
    # create a new internal hash
    def initialize
      @map = {}
    end

    # Returns boolean for existence of given key in the environment.
    def has_key?(key)
      @map.has_key?(key.to_sym)
    end

    # Returns the value for the given key.
    def [](key)
      @map[key.to_sym]
    end

    # Store the key/value pair.
    # It is only possible to store a value for a key once, otherwise a error will be raised.
    def []=(key, val)
      key = key.to_sym
      raise EnvironmentError, "#{key} already binded" if @map.has_key?(key)
      @map[key] = val
    end
  end
end
