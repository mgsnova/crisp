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
      FunctionRunner.run(@blk, env, args, name)
    end
  end
end
