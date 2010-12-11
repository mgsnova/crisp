module Crisp
  module Nodes
    # The integer node
    class IntegerLiteral < Primitive
      # returns integer value
      def eval(env)
        text_value.to_i
      end
    end
  end
end
