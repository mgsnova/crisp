module Crisp
  module Nodes
    # The operation node
    class Operation < Base
      # get the function binded to the given function name and eval it (including arguments)
      def eval(env)
        env[self.func_identifier.text_value].eval(env, self.element_list.elements.collect(&:element))
      end

      # an operation resolves to itself
      def resolve(env)
        self
      end
    end
  end
end
