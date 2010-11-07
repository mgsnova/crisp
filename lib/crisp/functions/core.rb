module Crisp
  module Functions
    class Core
      def self.load(env)

        Function.new('println', env) do
          print params_evaled.collect(&:to_s).join(' ') + "\n"
        end

        Function.new('def', env) do
          if params_values.size != 2
            raise ArgumentError, "wrong number of arguments for 'def' (#{params_values.size} for 2)"
          end

          env[params_values[0]] = params_values[1]
        end

      end
    end
  end
end
