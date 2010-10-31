module Crisp
  class Env

    def initialize
      @map = {}
    end

    def [](key)
      @map[key.to_sym]
    end

    def []=(key, val)
      key = key.to_sym
      raise "#{key} already binded" if @map.has_key?(key)
      @map[key] = val
    end
  end
end
