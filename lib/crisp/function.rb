module Crisp
  class Function
    attr_reader :name

    def initialize(name, env, &blk)
      @name = name.to_sym
      @blk = blk
      env[name] = self
    end

    def eval(env, params = [])
      @blk.call(env, values(env, params))
    end

    protected

    def values(env, params)
      params.map do |param|
        param.eval(env)
      end
    end
  end
end
