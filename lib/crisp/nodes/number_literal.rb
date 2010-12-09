module Crisp
  module Nodes
    class NumberLiteral < Primitive
      def eval(env)
        text_value.to_i
      end
    end
  end
end
