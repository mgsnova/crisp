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

    def eval(env, args = [])
      @env = env
      @args = args
      self.instance_eval(&@blk)
    end

    protected

    def validate_args_count(expected, got)
      if (expected.is_a?(Numeric) and expected != got) or
         (expected.is_a?(Range) and !(expected === got))
        raise ArgumentError, "wrong number of arguments for '#{name}' (#{got} for #{expected})"
      end
    end

    def args_values
      args.map do |arg|
        arg.eval(env)
      end
    end

    def args_evaled
      args_values.map do |arg|
        if arg.class.to_s == 'Symbol'
          if env[arg].respond_to?(:eval)
            env[arg].eval(env)
          else
            env[arg]
          end
        else
          arg
        end
      end
    end

    private

    def env
      @env
    end

    def args
      @args
    end
  end
end
