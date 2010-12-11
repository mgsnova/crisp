module Crisp
  # The Crisp function
  class Function
    attr_reader :name

    # create new function by calling new with a code block
    def initialize(&blk)
      @name = nil
      @blk = blk
    end

    # bind the function to the given name in the given environment
    def bind(name, env)
      @name = name.to_sym
      env[name] = self
    end

    # evaluate the function by using the given environment and argument list
    def eval(env, args = [])
      @env = env
      @args = args
      self.instance_eval(&@blk)
    end

    protected

    # raise an error if argument count got does not match the expected
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
