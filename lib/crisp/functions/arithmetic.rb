module Crisp
  module Functions
    class Arithmetic
      def self.load(env)

        Function.new('+', env) do |env, params|
          params.inject(:+)
        end

        Function.new('-', env) do |env, params|
          params.inject(:-)
        end

        Function.new('*', env) do |env, params|
          params.inject(:*)
        end

        Function.new('/', env) do |env, params|
          params.inject(:/)
        end

      end
    end
  end
end
