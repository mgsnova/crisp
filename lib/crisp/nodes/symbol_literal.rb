module Crisp
  module Nodes
    # The symbol node
    class SymbolLiteral < Primitive
      # return a symbol
      def eval(env)
        text_value.to_sym
      end
    end
  end
end
