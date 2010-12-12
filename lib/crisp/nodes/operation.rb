module Crisp
  module Nodes
    # The operation node
    class Operation < Base
      # get the function binded to the given function name and eval it (including arguments)
      def eval(env)
        if self.func_identifier.class.name == "Crisp::Nodes::Operation"
          self.func_identifier.eval(env).eval(env, self.element_list.elements.collect(&:element))
        else
          env[self.func_identifier.text_value].eval(env, self.element_list.elements.collect(&:element))
        end
      end

      # an operation resolves to itself
      def resolve(env)
        self
      end
    end
  end
end
