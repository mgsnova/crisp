require 'treetop'
require 'test/unit'

require 'crisp_context'
require 'crisp_nodes'

require 'pp'

Treetop.load 'crisp'

class CrispTestSuite < Test::Unit::TestCase
  def setup
    @parser = CrispParser.new
    @ctx = CrispContext.new
  end

  def test_addition
    @parser.parse("(+ 1 2 (+ 2 3) (- 5 1))").eval(@ctx)
    assert_equal 12, @ctx.last_return
  end
end
