module Crisp
  module Nodes
    # The base node
    class Base < Treetop::Runtime::SyntaxNode
      # this is only an abstract method
      def eval(env)
        raise "abstract method!"
      end

      # this is only an abstract method
      def resolve(env)
        raise "abstract method!"
      end

      # resolves the node and evals it it is a crisp operation node
      def resolve_and_eval(env)
        res = self.resolve(env)
        res.is_a?(Crisp::Nodes::Operation) ? res.eval(env) : res
      end
    end
  end
end
