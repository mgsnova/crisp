module Crisp
  module Functions
    class Arithmetic
      def self.load(current_env)

        Function.new do
          args_evaled.inject(:+)
        end.bind('+', current_env)

        Function.new do
          args_evaled.inject(:-)
        end.bind('-', current_env)

        Function.new do
          args_evaled.inject(:*)
        end.bind('*', current_env)

        Function.new do
          args_evaled.inject(:/)
        end.bind('/', current_env)

        Function.new do
          validate_args_count(2, args.size)
          values = args_evaled
          values[0] == values[1]
        end.bind('=', current_env)

        Function.new do
          validate_args_count(2, args.size)
          values = args_evaled
          values[0] > values[1]
        end.bind('>', current_env)

        Function.new do
          validate_args_count(2, args.size)
          values = args_evaled
          values[0] < values[1]
        end.bind('<', current_env)

      end
    end
  end
end
