module Crisp
  class ChainedEnv
    def initialize(first, second)
      @first = first
      @second = second
    end

    def [](key)
      if @first.has_key?(key)
        @first[key]
      else
        @second[key]
      end
    end

    def []=(key, val)
      @second[key] = val
    end
  end
end
