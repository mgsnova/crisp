module Crisp
  module Functions
    class Core
      def self.load(env)

        Function.new('println', env) do
          print params_evaled.collect(&:to_s).join(' ') + "\n"
        end

        Function.new('def', env) do
          validate_params_count(2, params.size)

          env[params_values[0]] = params_evaled[1]
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
            validate_params_count(fn_param_list.size, params.size)

            local_env = Env.new
            fn_param_list.each_with_index do |key, idx|
              local_env[key.eval(env)] = params[idx]
            end

            chained_env = ChainedEnv.new(local_env, env)

            fn_operation.eval(chained_env)
          end
        end

      end
    end
  end
end
