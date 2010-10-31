module Crisp
  class Base < Treetop::Runtime::SyntaxNode
    def eval(env)
      env
    end
  end

  class Operation < Base
    def eval(env)
      env.last_return = env[self.func_identifier.text_value].eval(env, self.list.elements.collect(&:parameter))
      env
    end
  end

  class Primitive < Base
  end

  class Number < Primitive
    def internal_value(env)
      text_value.to_i
    end
  end

  class Float < Primitive
    def internal_value(env)
      text_value.to_f
    end
  end

  class StringLiteral < Primitive
    def internal_value(env)
      text_value[1..-2]
    end
  end

  class Symbol < Primitive
    def internal_value(env)
      text_value.to_sym
    end
  end

  class Block < Base
    def eval(env)
      elements.each do |op|
        op.eval(env)
      end

      env
    end
  end
end
