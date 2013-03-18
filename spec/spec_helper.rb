require "rubygems"
require "pathname"
require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path

require SPEC_ROOT.parent + 'lib/crisp'

# Helper module for including into the specs,
# to parse and evaluate crisp code easily.
module Crisp
  module SpecHelper
    def parse(expr)
      Crisp::Parser.new.parse(expr)
    end

    def evaluate(expr)
      Crisp::Runtime.new.run(parse(expr))
    end
  end
end
