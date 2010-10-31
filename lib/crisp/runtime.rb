module Crisp
  class Runtime
    def initialize
      @env = Env.new
      Functions.load(@env)
    end

    def run(ast)
      ast.eval(@env)
    end
  end
end
