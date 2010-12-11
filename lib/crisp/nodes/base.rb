module Crisp
  module Nodes
    # The base node
    class Base < Treetop::Runtime::SyntaxNode
      # this is only an abstract method
      def eval(env)
        raise "abstract method!"
      end
    end
  end
end
