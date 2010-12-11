module Crisp
  module Functions
    # Defining arithemtic crisp functions
    class Arithmetic
      # load the functions and bind them into the given environment
      def self.load(current_env)

        # +
        # sum up all arguments
        #
        #  (+ 1 2 3)
        #  => 6
        Function.new do
          args_evaled.inject(:+)
        end.bind('+', current_env)

        # -
        # substract all arguments
        #
        #  (- 5 2 1)
        #  => 2
        Function.new do
          args_evaled.inject(:-)
        end.bind('-', current_env)

        # *
        # multiply all arguments
        #
        #  (* 2 3 4)
        #  => 24
        Function.new do
          args_evaled.inject(:*)
        end.bind('*', current_env)

        # /
        # divide all arguments
        #
        #  (/ 20 2 2)
        #  => 5
        Function.new do
          args_evaled.inject(:/)
        end.bind('/', current_env)

        # =
        # compare 2 arguments for equality
        #
        #  (= 1 2)
        #  => false
        Function.new do
          validate_args_count(2, args.size)
          values = args_evaled
          values[0] == values[1]
        end.bind('=', current_env)

        # >
        # compare 2 arguments for being greater than the other
        #
        #  (> 2 1)
        #  => true
        Function.new do
          validate_args_count(2, args.size)
          values = args_evaled
          values[0] > values[1]
        end.bind('>', current_env)

        # <
        # compare 2 arguments for being less than the other
        #
        #  (< 2 1)
        #  => false
        Function.new do
          validate_args_count(2, args.size)
          values = args_evaled
          values[0] < values[1]
        end.bind('<', current_env)

      end
    end
  end
end
