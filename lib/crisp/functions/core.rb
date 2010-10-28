module Crisp
  module Functions
    class Core
      def self.load(env)

        Function.new('println', env) do |env, params|
          print params.collect(&:to_s).join(' ') + "\n"
        end

        Function.new('def', env) do |env, params|
          raise "wrong number of arguments for 'def' (#{params.size} for 2)" if params.size != 2
          env[params[0]] = params[1]
        end

      end
    end
  end
end
