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

  class Symbol < Primitive
    def internal_value(env)
      text_value
    end
  end

  class Block < Base
    def eval(env)
      list = [operation]

      if !operations.elements.empty?
        list += operations.elements.map { |op| op.operation }
      end

      list.each do |op|
        op.eval(env)
      end

      env
    end
  end
end
