module Crisp
  class Function
    attr_reader :name

    def initialize(name, env, &blk)
      @name = name.to_sym
      @blk = blk
      env[name] = self
    end

    def eval(env, params = [])
      @env = env
      @params = params
      self.instance_eval(&@blk)
    end

    protected

    def params_values
      params.map do |param|
        param.eval(env)
      end
    end

    def params_evaled
      params_values.map do |param|
        if param.class.to_s == 'Symbol'
          if env[param].respond_to?(:eval)
            env[param].eval(env)
          else
            env[param]
          end
        else
          param
        end
      end
    end

    private

    def env
      @env
    end

    def params
      @params
    end
  end
end
