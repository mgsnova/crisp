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

    # returns the resolved/evaled argument list
    def args_evaled
      args.map do |arg|
        arg.resolve_and_eval(env)
      end
    end

    private

    # returns the env of the function is evaled with at the moment
    def env
      @env
    end

    # returns the argument list the function is evaled with at the moment
    def args
      @args
    end
  end
end
