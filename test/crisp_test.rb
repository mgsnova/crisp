require 'test/unit'
require 'lib/crisp'

class CrispTestSuite < Test::Unit::TestCase
  def setup
    @runtime = Crisp::Runtime.new
  end

  def test_addition
    @runtime.run("(+ 1 2 (+ 2 3) (- 5 1))")
    assert_equal 12, @runtime.last_return
  end
end
