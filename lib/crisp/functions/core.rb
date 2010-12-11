module Crisp
  module Functions
    # Defining core crisp functions
    class Core
      # load the functions and bind them into the given environment
      def self.load(current_env)

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

          value = args_evaled[1]

          if value.class.name == "Crisp::Function"
            value.bind(args[0].eval(env), env)
          else
            env[args[0].eval(env)] = value
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

          Function.new do
            validate_args_count(fn_arg_list.size, args.size)

            local_env = Env.new
            fn_arg_list.each_with_index do |key, idx|
              local_env[key.eval(env)] = if args[idx].class.name == "Crisp::Nodes::Operation"
                args[idx].eval(env)
              else
                args[idx]
              end
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

          result = args[0].eval(env)

          if ![nil, false].include?(result)
            args[1].eval(env)
          elsif args[2]
            args[2].eval(env)
          end
        end.bind('if', current_env)

      end
    end
  end
end
