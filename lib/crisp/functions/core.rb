module Crisp
  module Functions
    class Core
      def self.load(env)

        Function.new('println', env) do |env, params|
          print params.collect(&:to_s).join(' ') + "\n"
        end

      end
    end
  end
end
