require "rubygems"
require "treetop"
require "pp"

module Crisp
  VERSION = '0.0.3'
end

require 'crisp/errors'
require 'crisp/parser'
require 'crisp/runtime'
require 'crisp/chained_env'
require 'crisp/env'
require 'crisp/nodes'
require 'crisp/function'
require 'crisp/functions'
require 'crisp/shell'
