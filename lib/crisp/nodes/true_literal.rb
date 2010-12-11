module Crisp
  module Nodes
    # The true node
    class TrueLiteral < Primitive
      # yes it evals to true
      def eval(env)
        true
      end
    end
  end
end
