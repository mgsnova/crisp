module Crisp
  class Parser
    Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'crisp.treetop')))

    def initialize
      @parser = CrispParser.new
    end

    def parse(code)
      ast = @parser.parse(code)

      raise StandardError, "syntax error at : #{@parser.index}" if !ast

      ast
    end
  end
end
