module Crisp
  module Nodes
    # The true node
    class TrueLiteral < Primitive
      # yes it resolves to true
      def resolve(env)
        true
      end
    end
  end
end
