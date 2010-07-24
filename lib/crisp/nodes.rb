module Crisp

  class Base < Treetop::Runtime::SyntaxNode
    def eval(context)
      context
    end
  end

  class Primitive < Base
  end

  class Func < Base
    def eval_args(context, params)
      params.map do |param|
        if param.class.superclass == Primitive
          param.internal_value(context)
        elsif param.class == Operation
          param.eval(context)
          context.last_return
        end
      end
    end
  end

  class Operation < Base
    def eval(context)
      context.last_return = self.func.eval(context, self.list.elements.collect(&:parameter))
      context
    end
  end

  class Number < Primitive
    def internal_value(context)
      text_value.to_i
    end

    def eval(context)
      context
    end
  end

  class FuncAdd < Func
    def eval(context, params = [])
      eval_args(context, params).inject(:+)
    end
  end

  class FuncSub < Func
    def eval(context, params = [])
      eval_args(context, params).inject(:-)
    end
  end
end
