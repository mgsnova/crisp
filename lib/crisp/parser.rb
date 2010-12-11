module Crisp
  # The Crisp parser
  #
  # The parser uses treetop for defining the syntax (see crisp.treetop)
  # For parsing crisp code (as string) call parse on a instance.
  # The output of the parser can be evaluated by passing it to a Crisp runtime.
  class Parser
    Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'crisp.treetop')))

    # create a new treetop parser
    def initialize
      @parser = CrispParser.new
    end

    # parse the code and return an abstract syntax tree (ast)
    def parse(code)
      ast = @parser.parse(code)

      raise SyntaxError, "syntax error at : #{@parser.index}" if !ast

      ast
    end
  end
end
