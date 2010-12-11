module Crisp
  module Nodes
    # The float node
    class FloatLiteral < Primitive
      # returns float value
      def eval(env)
        text_value.to_f
      end
    end
  end
end
