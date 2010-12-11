module Crisp
  module Nodes
    # The array node
    class ArrayLiteral < Base
      # eval each array element and return it as array
      def eval(env)
        raw_elements.map { |e| e.eval(env) }
      end

      # an array resolves to its raw elements
      def resolve(env)
        raw_elements.map { |e| e.resolve(env) }
      end

      # return an array with the raw parsed array elements
      def raw_elements
        self.element_list.elements.collect(&:element)
      end
    end
  end
end
