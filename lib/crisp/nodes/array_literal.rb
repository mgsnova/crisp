module Crisp
  module Nodes
    class ArrayLiteral < Base
      def eval(env)
        raw_elements.map { |e| e.eval(env) }
      end

      def raw_elements
        self.element_list.elements.collect(&:element)
      end
    end
  end
end
