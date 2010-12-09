module Crisp
  module Nodes
    class Block < Base
      def eval(env)
        last_result = nil

        elements.each do |op|
          last_result = op.eval(env)
        end

        last_result
      end
    end
  end
end
