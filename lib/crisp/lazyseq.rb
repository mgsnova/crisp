module Crisp
  # Lazy Sequence class
  class Lazyseq
    # constructor, creates enumerator from given code block
    def initialize(&blk)
      @enum = Enumerator.new do |yielder|
        self.instance_exec yielder do
          @emitter = yielder
          self.instance_eval &blk
        end
      end
      @lock = Mutex.new
    end

    # emit value to internal emitter (should only be called from within enumerator)
    def emit(val)
      @emitter.yield val
    end

    # get next value from sequence
    def next
      @lock.synchronize do
        @enum.next
      end
    end
  end
end
