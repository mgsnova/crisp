module Crisp
  module Nodes
    class FloatLiteral < Primitive
      def eval(env)
        text_value.to_f
      end
    end
  end
end
