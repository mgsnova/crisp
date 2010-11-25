module Crisp
  module Functions
    class Core
      def self.load(env)

        Function.new('println', env) do
          print params_evaled.collect(&:to_s).join(' ') + "\n"
        end

        Function.new('def', env) do
          validate_params_count(2, params.size)

          env[params_values[0]] = params_values[1]
        end

        Function.new('fn', env) do
          validate_params_count(2, params.size)

          if params[0].class.name != "Crisp::ArrayLiteral"
            raise ArgumentError, "no parameter list defined"
          end

          if params[1].class.name != "Crisp::Operation"
            raise ArgumentError, "no function body defined"
          end

          fn_param_list = params[0].raw_elements
          fn_operation = params[1]

          Function.new(nil, env) do
            # TODO create chained env with parameterlist binding
            validate_params_count(fn_param_list.size, params.size)
            fn_operation.eval(env)
          end
        end

      end
    end
  end
end
