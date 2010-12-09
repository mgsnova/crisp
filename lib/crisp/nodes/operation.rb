module Crisp
  module Nodes
    class Operation < Base
      def eval(env)
        env[self.func_identifier.text_value].eval(env, self.element_list.elements.collect(&:element))
      end
    end
  end
end
