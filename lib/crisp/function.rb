module Crisp
  class Function
    attr_reader :name

    def initialize(name, env, &blk)
      @name = name
      @blk = blk
      env[name.to_s] = self
    end

    def eval_args(env, params)
      params.map do |param|
        if param.class.superclass == Primitive
          param.eval(env)
        elsif param.class == Operation
          param.eval(env)
        else
          param
        end
      end
    end

    def eval(env, params = [])
      @blk.call(env, eval_args(env, params))
    end
  end
end
