module Crisp
  module Nodes
    class FalseLiteral < Primitive
      def eval(env)
        false
      end
    end
  end
end
