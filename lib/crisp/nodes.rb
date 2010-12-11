module Crisp
  module Nodes
    # require all used node types
    #
    # hierarchy:
    #
    #   Base
    #   + Operation
    #   + Block
    #   + Array
    #   + Primitive
    #     + Integer
    #     + Float
    #     + String
    #     + Symbol
    #     + True
    #     + False
    #     + Nil

    require 'crisp/nodes/base'
    require 'crisp/nodes/operation'
    require 'crisp/nodes/block'
    require 'crisp/nodes/array_literal'
    require 'crisp/nodes/primitive'
    require 'crisp/nodes/integer_literal'
    require 'crisp/nodes/float_literal'
    require 'crisp/nodes/string_literal'
    require 'crisp/nodes/symbol_literal'
    require 'crisp/nodes/true_literal'
    require 'crisp/nodes/false_literal'
    require 'crisp/nodes/nil_literal'
  end
end
