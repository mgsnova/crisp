module Crisp
  class NativeCallInvoker
    def initialize(target, method, *args)
      @target = target
      @method = method
      @args = args.flatten
    end

    def invoke!
      if @args.size.zero?
        @target.send(@method)
      else
        @target.send(@method, *@args)
      end
    end
  end
end
