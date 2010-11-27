module Crisp
  class Function
    attr_reader :name

    def initialize(&blk)
      @name = nil
      @blk = blk
    end

    def bind(name, env)
      @name = name.to_sym
      env[name] = self
    end

    def eval(env, params = [])
      @env = env
      @params = params
      self.instance_eval(&@blk)
    end

    protected

    def validate_params_count(expected, got)
      if expected != got
        raise ArgumentError, "wrong number of arguments for '#{name}' (#{got} for #{expected})"
      end
    end

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
