module Crisp
  module Nodes
    # The block node
    class Block < Base
      # eval each element of the block and return the last result
      def eval(env)
        elements.map do |op|
          op.resolve_and_eval(env)
        end.last
      end

      # a block resolves to itself
      def resolve(env)
        self
      end
    end
  end
end
