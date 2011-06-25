module Crisp
  module Functions
    # Defining sequence crisp functions
    class Sequence
      # load the functions and bind them into the given environment
      def self.load(current_env)

        # lazyseq
        # Create a lazy sequence
        #
        #  (def numbers
        #    (lazyseq
        #      (loop [cnt 1]
        #        (emit cnt)
        #        (recur (+ cnt 1)))))
        #  (next numbers)
        Function.new do
          operations = args[0..-1]
          local_env = Env.new
          chained_env = ChainedEnv.new(local_env, env)

          seq = Lazyseq.new do
            operations.map do |op|
              op.resolve_and_eval(chained_env)
            end.last
          end

          Function.new do
            validate_args_count(1, args.size)
            seq.emit args.first.resolve_and_eval(env)
          end.bind('emit', local_env)

          seq
        end.bind('lazyseq', current_env)

        # next
        # Get next item from a sequence
        # see 'lazyseq' for example
        Function.new do
          validate_args_count(1, args.size)

          seq = args.first.resolve_and_eval(env)

          if seq.class.name != "Crisp::Lazyseq"
            raise ArgumentError, "argument is not a sequence"
          end

          seq.next
        end.bind('next', current_env)

      end
    end
  end
end

