module Crisp
  module Nodes
    class Base < Treetop::Runtime::SyntaxNode
      def eval(env)
        nil
      end
    end
  end
end
