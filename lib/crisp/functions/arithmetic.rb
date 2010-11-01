module Crisp
  module Functions
    class Arithmetic
      def self.load(env)

        Function.new('+', env) do
          params_evaled.inject(:+)
        end

        Function.new('-', env) do
          params_evaled.inject(:-)
        end

        Function.new('*', env) do
          params_evaled.inject(:*)
        end

        Function.new('/', env) do
          params_evaled.inject(:/)
        end

      end
    end
  end
end
