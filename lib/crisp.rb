require "rubygems"
require "treetop"
require "pp"

module Crisp
  VERSION = '0.1.0'
end

require 'crisp/errors'
require 'crisp/parser'
require 'crisp/runtime'
require 'crisp/chained_env'
require 'crisp/env'
require 'crisp/nodes'
require 'crisp/function'
require 'crisp/function_runner'
require 'crisp/functions'
require 'crisp/shell'
require 'crisp/native_call_invoker'
require 'crisp/lazyseq'
