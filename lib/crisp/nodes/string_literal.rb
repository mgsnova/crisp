module Crisp
  module Nodes
    class StringLiteral < Primitive
      def eval(env)
        text_value[1..-2]
      end
    end
  end
end
