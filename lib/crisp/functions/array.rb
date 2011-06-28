module Crisp
  module Functions
    # Defining array crisp functions
    class Array
      # load the functions and bind them into the given environment
      def self.load(current_env)

        # head
        # return head of array
        #
        #  (head [1 2 3])
        #  => 1
        Function.new do
          validate_args_count(1, args.size)

          if !args[0].is_a?(Crisp::Nodes::ArrayLiteral)
            raise ArgumentError, "argument is not an array"
          end

          if raw_head = args[0].raw_elements[0]
            raw_head.resolve(env)
          else
            nil
          end
        end.bind('head', current_env)

        # tail
        # return tail of array
        #
        #  (tail [1 2 3])
        #  => [2 3]
        Function.new do
          validate_args_count(1, args.size)

          if !args[0].is_a?(Crisp::Nodes::ArrayLiteral)
            raise ArgumentError, "argument is not an array"
          end

          if raw_tail = args[0].raw_elements[1..-1]
            raw_tail.map { |arg| arg.resolve(env) }
          else
            []
          end
        end.bind('tail', current_env)

      end
    end
  end
end
