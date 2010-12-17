module Crisp
  # The FunctionRunner can eval function calls by instance_eval the function block
  class FunctionRunner
    attr_reader :name, :args, :env

    # run the blk
    def self.run(blk, env, args, name)
      runner = new(env, args, name)
      runner.instance_eval(&blk)
    end

    # save name, environment and arguments on creation
    def initialize(env, args, name)
      @name = name
      @env = env
      @args = args
    end

    protected
    # following methods are used for calling from the function block

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
  end
end
