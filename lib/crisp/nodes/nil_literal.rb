module Crisp
  module Nodes
    # The nil node
    class NilLiteral < Primitive
      # yes it resolves to nil
      def resolve(env)
        nil
      end
    end
  end
end
