module Crisp
  module Nodes
    # The operation node
    class Operation < Base
      # get the function binded to the given function name and eval it (including arguments)
      def eval(env)
        if self.func_identifier.is_a?(Crisp::Nodes::Operation)
          self.func_identifier.eval(env).eval(env, raw_element_list)
        else
          env[self.func_identifier.text_value].eval(env, raw_element_list)
        end
      end

      # an operation resolves to itself
      def resolve(env)
        self
      end

      private

      def raw_element_list
        self.element_list.elements.collect(&:element)
      end
    end
  end
end
