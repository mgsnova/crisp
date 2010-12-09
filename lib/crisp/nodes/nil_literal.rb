module Crisp
  module Nodes
    class NilLiteral < Primitive
      def eval(env)
        nil
      end
    end
  end
end
