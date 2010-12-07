module Crisp
  class Base < Treetop::Runtime::SyntaxNode
    def eval(env)
      nil
    end
  end

  class Operation < Base
    def eval(env)
      env[self.func_identifier.text_value].eval(env, self.element_list.elements.collect(&:element))
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

  class ArrayLiteral < Base
    def eval(env)
      raw_elements.map { |e| e.eval(env) }
    end

    def raw_elements
      self.element_list.elements.collect(&:element)
    end
  end

  class Primitive < Base
  end

  class Number < Primitive
    def eval(env)
      text_value.to_i
    end
  end

  class Float < Primitive
    def eval(env)
      text_value.to_f
    end
  end

  class StringLiteral < Primitive
    def eval(env)
      text_value[1..-2]
    end
  end

  class Symbol < Primitive
    def eval(env)
      text_value.to_sym
    end
  end

  class True < Primitive
    def eval(env)
      true
    end
  end

  class False < Primitive
    def eval(env)
      false
    end
  end

  class Nil < Primitive
    def eval(env)
      nil
    end
  end
end
