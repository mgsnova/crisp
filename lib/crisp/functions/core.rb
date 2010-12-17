module Crisp
  module Functions
    # Defining core crisp functions
    class Core
      # load the functions and bind them into the given environment
      def self.load(current_env)

        # reserve nil/true/false in environment
        current_env['nil'] = nil
        current_env['true'] = true
        current_env['false'] = false

        # println
        # print arguments (seperated by whitspace) including a newline to the standard output
        #
        #  (println 123)
        #  123
        Function.new do
          print args_evaled.collect(&:to_s).join(' ') + "\n"
        end.bind('println', current_env)

        # def
        # bind the second argument to the symbol name of the first argument
        # actually a key/value pair will be stored in the environment
        #
        #  (def foo 1)
        #  => foo
        #  (println foo)
        #  1
        Function.new do
          validate_args_count(2, args.size)

          key = args[0].text_value
          value = args[1].resolve_and_eval(env)

          if value.class.name == "Crisp::Function"
            value.bind(key, env)
          else
            env[key] = value
          end
        end.bind('def', current_env)

        # fn
        # creates a function
        # the first argument has to be an array containing the argumentlist
        # the second argument is the function body
        #
        #  (fn [a b] (+ a b)
        #  => ...)
        Function.new do
          validate_args_count(2, args.size)

          if args[0].class.name != "Crisp::Nodes::ArrayLiteral"
            raise ArgumentError, "no argument list defined"
          end

          if args[1].class.name != "Crisp::Nodes::Operation"
            raise ArgumentError, "no function body defined"
          end

          fn_arg_list = args[0].raw_elements
          fn_operation = args[1]

          # create and return the new function
          Function.new do
            validate_args_count(fn_arg_list.size, args.size)

            local_env = Env.new
            fn_arg_list.each_with_index do |key, idx|
              local_env[key.text_value] = args[idx].resolve_and_eval(env)
            end

            chained_env = ChainedEnv.new(local_env, env)

            fn_operation.eval(chained_env)
          end
        end.bind('fn', current_env)

        # if
        # the if function evaluates the second argument if the condition (first argument) returns not nil or false.
        # Otherwise the third argument will be evaluated (optional)
        #
        #  (if (= 1 2) 1 2)
        #  => 2
        Function.new do
          validate_args_count((2..3), args.size)

          result = args[0].resolve_and_eval(env)

          res = if ![nil, false].include?(result)
            args[1]
          elsif args[2]
            args[2]
          end

          res ? res.resolve_and_eval(env) : res
        end.bind('if', current_env)

        # . native-call target-object arg1 arg2 ..
        Function.new do
          meth = args[0].text_value.to_sym
          target = args[1].resolve_and_eval(env)
          values = args[2..-1].map { |arg| arg.resolve_and_eval(env) }

          NativeCallInvoker.new(target, meth, values).invoke!
        end.bind('.', current_env)

      end
    end
  end
end
