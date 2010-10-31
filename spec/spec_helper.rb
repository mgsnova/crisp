require "rubygems"
require "pathname"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path

require SPEC_ROOT.parent + 'lib/crisp'

module Crisp
  module SpecHelper
    def parse(expr)
      CrispParser.new.parse(expr)
    end

    def evaluate(expr)
      Crisp::Runtime.new.run(parse(expr))
    end
  end
end
