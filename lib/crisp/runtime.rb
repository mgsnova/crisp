module Crisp
  class Runtime
    def initialize
      @parser = CrispParser.new
      @env = Env.new
      Functions.load(@env)
    end

    def parse(str)
      @parser.parse(str)
    end

    def run(str)
      parse(str).eval(@env)
    end

    def last_return
      @env.last_return
    end
  end
end
