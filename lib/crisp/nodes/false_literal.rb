module Crisp
  module Nodes
    # The false node
    class FalseLiteral < Primitive
      # yes it resolves to false
      def resolve(env)
        false
      end
    end
  end
end
