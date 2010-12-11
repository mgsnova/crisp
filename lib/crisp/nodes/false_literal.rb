module Crisp
  module Nodes
    # The false node
    class FalseLiteral < Primitive
      # yes it evals to false
      def eval(env)
        false
      end
    end
  end
end
