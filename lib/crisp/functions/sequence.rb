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
        #  => 1
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

          if !seq.is_a?(Crisp::Lazyseq)
            raise ArgumentError, "argument is not a sequence"
          end

          seq.next
        end.bind('next', current_env)

        # take
        # returns an array with the specified count of values from the sequence
        #
        #  (def numbers
        #    (lazyseq
        #      (loop [cnt 1]
        #        (emit cnt)
        #        (recur (+ cnt 1)))))
        #  (take 5 numbers)
        #  => [1,2,3,4,5]
        Function.new do
          validate_args_count(2, args.size)
          
          n = args.first.resolve_and_eval(env)
          seq = args.last.resolve_and_eval(env)

          if !seq.is_a?(Crisp::Lazyseq)
            raise ArgumentError, "argument is not a sequence"
          end

          result = []

          n.times do
            result << seq.next
          end

          result
        end.bind('take', current_env)

        # nth
        # returns the n'th value from the sequence
        #
        #  (def numbers
        #    (lazyseq
        #      (loop [cnt 1]
        #        (emit cnt)
        #        (recur (+ cnt 1)))))
        #  (nth 5 numbers)
        #  => 5
        Function.new do
          validate_args_count(2, args.size)
          
          n = args.first.resolve_and_eval(env)
          seq = args.last.resolve_and_eval(env)

          if !seq.is_a?(Crisp::Lazyseq)
            raise ArgumentError, "argument is not a sequence"
          end

          result = nil

          n.times do
            result = seq.next
          end

          result
        end.bind('nth', current_env)

      end
    end
  end
end

