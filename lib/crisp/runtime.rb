module Crisp
  class Runtime
    def initialize(ast)
      @ast = ast
      @env = Env.new
      Functions.load(@env)
    end

    def run
      @ast.eval(@env)
    end

    def last_return
      @env.last_return
    end
  end
end
