module Crisp
  # class for handling native ruby method invokations
  class NativeCallInvoker
    # create instance with target object, method to be called and arguments
    def initialize(target, method, *args)
      @target = target
      @method = method
      @args = args.flatten
    end

    # invoke the native ruby call
    def invoke!
      @target.send(@method, *@args)
    end
  end
end
