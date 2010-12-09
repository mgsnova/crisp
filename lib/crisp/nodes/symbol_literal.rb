module Crisp
  module Nodes
    class SymbolLiteral < Primitive
      def eval(env)
        text_value.to_sym
      end
    end
  end
end
