module Crisp
  module Nodes
    # The primitive node
    class Primitive < Base
      # raise error if trying to eval a primitve
      def eval(env)
        raise "cannot eval primitive"
      end

      # abstract method
      def resolve(env)
        raise "abstract method!"
      end
    end
  end
end
