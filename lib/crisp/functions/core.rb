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

            fn_operation.resolve_and_eval(chained_env)
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

        # cond
        # cond works like a switch/case statement, evaluating the first expression where the condition matches
        #
        #  (cond
        #   false (println "should not be printed")
        #   true (println "should be printed"))
        Function.new do
          if args.size.odd?
            raise ArgumentError, "argument list has to contain even list of arguments"
          end

          result = nil

          args.each_with_index do |arg, idx|
            next if idx.odd?
            if (arg.class.name == 'Crisp::Nodes::SymbolLiteral' and arg.text_value == 'else') or
               (![nil, false].include?(arg.resolve_and_eval(env)))
              result = args[idx + 1].resolve_and_eval(env)
              break
            end
          end

          result
        end.bind("cond", current_env)

        # let
        # create local binding only valid within let and evaluate expressions
        #
        #  (let [x 1 y 2] (+ x y))
        #  => 3
        Function.new do
          if args[0].class.name != "Crisp::Nodes::ArrayLiteral"
            raise ArgumentError, "no argument list defined"
          end

          if args[0].raw_elements.size.odd?
            raise ArgumentError, "argument list has to contain even list of arguments"
          end

          local_env = Env.new
          chained_env = ChainedEnv.new(local_env, env)
          binding_array = args[0].raw_elements

          binding_array.each_with_index do |key, idx|
            next if idx.odd?
            local_env[key.text_value] = binding_array[idx+1].resolve_and_eval(chained_env)
          end

          args[1..-1].map do |op|
            op.resolve_and_eval(chained_env)
          end.last
        end.bind('let', current_env)

        # loop
        # create loop with a local binding, perform a loopjump using recur
        #
        #  (loop [cnt 5 acc 1]
        #    (if (= 0 cnt)
        #      acc
        #      (recur (- cnt 1) (* acc cnt))))
        #  => 120
        Function.new do
          if env.global_loop_data
            raise LoopError, "nested loops are not allowed"
          end

          if args[0].class.name != "Crisp::Nodes::ArrayLiteral"
            raise ArgumentError, "no argument list defined"
          end

          if args[0].raw_elements.size.odd?
            raise ArgumentError, "argument list has to contain even list of arguments"
          end

          local_env = Env.new
          chained_env = ChainedEnv.new(local_env, env)
          binding_array = args[0].raw_elements
          argument_name_array = []

          binding_array.each_with_index do |key, idx|
            next if idx.odd?
            local_env[key.text_value] = binding_array[idx+1].resolve_and_eval(chained_env)
            argument_name_array << key.text_value
          end

          env.global_loop_data = {
            :operations => args[1..-1],
            :argument_names =>  argument_name_array
          }

          result = args[1..-1].map do |op|
            op.resolve_and_eval(chained_env)
          end.last

          env.global_loop_data = nil

          result
        end.bind('loop', current_env)

        # recur
        # only used inside a loop. recur will trigger a new run of the loop
        # see 'loop' for an example
        Function.new do
          if !env.global_loop_data
            raise LoopError, "recur called outside loop"
          end

          validate_args_count(env.global_loop_data[:argument_names].size, args.size)

          local_env = Env.new
          chained_env = ChainedEnv.new(local_env, env)

          env.global_loop_data[:argument_names].each_with_index do |key, idx|
            local_env[key] = args[idx].resolve_and_eval(env)
          end

          env.global_loop_data[:operations].map do |op|
            op.resolve_and_eval(chained_env)
          end.last
        end.bind('recur', current_env)

        # .
        # perform a native call on an object with optional arguments
        #
        #  (. upcase "abc")
        #  => "ABC"
        Function.new do
          meth = args[0].text_value.to_sym
          target = if args[1].class.name == "Crisp::Nodes::SymbolLiteral" and !env.has_key?(args[1].text_value)
            Object.const_get(args[1].text_value)
          else
            args[1].resolve_and_eval(env)
          end
          values = args[2..-1].map { |arg| arg.resolve_and_eval(env) }

          NativeCallInvoker.new(target, meth, values).invoke!
        end.bind('.', current_env)

        # load
        # include content of another crisp source file
        #
        #  (load "business_logic")
        #  => true
        Function.new do
          args_evaled.collect(&:to_s).each do |filename|
            pwd = `pwd`.strip
            file = if filename[0..1] == '/'
              File.join(pwd, filename)
            else
              filename
            end.sub(".crisp$", '') + '.crisp'

            if !File.exists?(file)
              raise Crisp::ArgumentError, "file #{file} not found"
            end

            filecontent = File.read(file)
            ast = Crisp::Parser.new.parse(filecontent)
            Crisp::Runtime.new(env).run(ast)
          end

          true
        end.bind('load', current_env)

        # alias
        # create alias from one symbol to another
        # 
        #  (alias p println)
        #  (p 123)
        #  123 
        Function.new do
          validate_args_count(2, args.size)

          to = args[0].text_value
          from = args[1].text_value

          env.alias(to, from)
        end.bind('alias', current_env)

      end
    end
  end
end
