module Crisp
  class Base < Treetop::Runtime::SyntaxNode
    def eval(env)
      env
    end
  end

  class Operation < Base
    def eval(env)
      env[self.func_identifier.text_value].eval(env, self.list.elements.collect(&:parameter))
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
      last_result = nil

      elements.each do |op|
        last_result = op.eval(env)
      end

      last_result
    end
  end
end
