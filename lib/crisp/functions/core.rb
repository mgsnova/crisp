module Crisp
  module Functions
    class Core
      def self.load(env)

        Function.new do
          print params_evaled.collect(&:to_s).join(' ') + "\n"
        end.bind('println', env)

        Function.new do
          validate_params_count(2, params.size)

          value = params_evaled[1]

          if value.class.name == "Crisp::Function"
            value.bind(params_values[0], env)
          else
            env[params_values[0]] = value
          end
        end.bind('def', env)

        Function.new do
          validate_params_count(2, params.size)

          if params[0].class.name != "Crisp::ArrayLiteral"
            raise ArgumentError, "no parameter list defined"
          end

          if params[1].class.name != "Crisp::Operation"
            raise ArgumentError, "no function body defined"
          end

          fn_param_list = params[0].raw_elements
          fn_operation = params[1]

          Function.new do
            validate_params_count(fn_param_list.size, params.size)

            local_env = Env.new
            fn_param_list.each_with_index do |key, idx|
              local_env[key.eval(env)] = params[idx]
            end

            chained_env = ChainedEnv.new(local_env, env)

            fn_operation.eval(chained_env)
          end
        end.bind('fn', env)

      end
    end
  end
end
