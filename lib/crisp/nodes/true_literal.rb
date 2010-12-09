module Crisp
  module Nodes
    class TrueLiteral < Primitive
      def eval(env)
        true
      end
    end
  end
end
