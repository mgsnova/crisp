module Crisp
  module Functions
    class Core
      def self.load(current_env)

        Function.new do
          print params_evaled.collect(&:to_s).join(' ') + "\n"
        end.bind('println', current_env)

        Function.new do
          validate_params_count(2, params.size)

          value = params_evaled[1]

          if value.class.name == "Crisp::Function"
            value.bind(params[0].eval(env), env)
          else
            env[params[0].eval(env)] = value
          end
        end.bind('def', current_env)

        Function.new do
          validate_params_count(2, params.size)

          if params[0].class.name != "Crisp::Nodes::ArrayLiteral"
            raise ArgumentError, "no parameter list defined"
          end

          if params[1].class.name != "Crisp::Nodes::Operation"
            raise ArgumentError, "no function body defined"
          end

          fn_param_list = params[0].raw_elements
          fn_operation = params[1]

          Function.new do
            validate_params_count(fn_param_list.size, params.size)

            local_env = Env.new
            fn_param_list.each_with_index do |key, idx|
              local_env[key.eval(env)] = if params[idx].class.name == "Crisp::Nodes::Operation"
                params[idx].eval(env)
              else
                params[idx]
              end
            end

            chained_env = ChainedEnv.new(local_env, env)

            fn_operation.eval(chained_env)
          end
        end.bind('fn', current_env)

        Function.new do
          validate_params_count((2..3), params.size)

          result = params[0].eval(env)

          if ![nil, false].include?(result)
            params[1].eval(env)
          elsif params[2]
            params[2].eval(env)
          end
        end.bind('if', current_env)

      end
    end
  end
end
