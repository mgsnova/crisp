module Crisp
  module Functions
    class Arithmetic
      def self.load(current_env)

        Function.new do
          params_evaled.inject(:+)
        end.bind('+', current_env)

        Function.new do
          params_evaled.inject(:-)
        end.bind('-', current_env)

        Function.new do
          params_evaled.inject(:*)
        end.bind('*', current_env)

        Function.new do
          params_evaled.inject(:/)
        end.bind('/', current_env)

        Function.new do
          validate_params_count(2, params.size)
          values = params_evaled
          values[0] == values[1]
        end.bind('=', current_env)

        Function.new do
          validate_params_count(2, params.size)
          values = params_evaled
          values[0] > values[1]
        end.bind('>', current_env)

        Function.new do
          validate_params_count(2, params.size)
          values = params_evaled
          values[0] < values[1]
        end.bind('<', current_env)

      end
    end
  end
end
