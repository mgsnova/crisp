module Crisp
  module Nodes
    # The string node
    class StringLiteral < Primitive
      # return a string
      def resolve(env)
        text_value[1..-2]
      end
    end
  end
end
