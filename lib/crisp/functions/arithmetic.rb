module Crisp
  module Functions
    class Arithmetic
      def self.load(env)

        Function.new do
          params_evaled.inject(:+)
        end.bind('+', env)

        Function.new do
          params_evaled.inject(:-)
        end.bind('-', env)

        Function.new do
          params_evaled.inject(:*)
        end.bind('*', env)

        Function.new do
          params_evaled.inject(:/)
        end.bind('/', env)

      end
    end
  end
end
