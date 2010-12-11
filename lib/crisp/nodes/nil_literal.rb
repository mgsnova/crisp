module Crisp
  module Nodes
    # The nil node
    class NilLiteral < Primitive
      # yes it evals to nil
      def eval(env)
        nil
      end
    end
  end
end
