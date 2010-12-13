module Crisp
  module Nodes
    # The block node
    class Block < Base
      # eval each element of the block and return the last result
      def eval(env)
        last_result = nil

        elements.each do |op|
          last_result = op.resolve_and_eval(env)
        end

        last_result
      end

      # a block resolves to itself
      def resolve(env)
        self
      end
    end
  end
end
