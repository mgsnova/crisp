module Crisp
  module Functions
    class Arithmetic
      def self.load(env)

        Function.new('+', env) do
          eval_symbols(env, params).inject(:+)
        end

        Function.new('-', env) do
          eval_symbols(env, params).inject(:-)
        end

        Function.new('*', env) do
          eval_symbols(env, params).inject(:*)
        end

        Function.new('/', env) do
          eval_symbols(env, params).inject(:/)
        end

      end
    end
  end
end
