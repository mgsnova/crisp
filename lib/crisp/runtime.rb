module Crisp
  # The Crisp Runtime
  #
  # Each runtime holds its own environment.
  # All predefined functions are loaded when creating a new runtime.
  # Run code by calling run with the output of the parser as argurment.
  class Runtime
    # create a new env and load all functions when creating a new runtime
    def initialize(env = nil)
      @env = env || Env.new
      Functions.load(@env) if !env
    end

    # run the parsed code (abstract syntax tree)
    def run(ast)
      ast.eval(@env)
    end
  end
end
