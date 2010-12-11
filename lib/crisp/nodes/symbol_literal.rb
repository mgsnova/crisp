module Crisp
  module Nodes
    # The symbol node
    class SymbolLiteral < Primitive
      # return the value for the key in the env the symbol stays for
      def resolve(env)
        env[text_value]
      end
    end
  end
end
