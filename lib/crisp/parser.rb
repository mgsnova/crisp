module Crisp
  class Parser
    Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'crisp.treetop')))

    def initialize
      @parser = CrispParser.new
    end

    def parse(code)
      @parser.parse(code)
    end
  end
end
