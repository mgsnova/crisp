require 'spec_helper'

describe "the language" do

  include Crisp::SpecHelper

  before(:each) do
    @runtime = Crisp::Runtime.new
  end

  it "should be able to calculate basic addition and substraction" do
    evaluate("(+ 1 2 (+ 2 3) (- 5 1))").should == 12
  end

  it "should be able to parse multiline statements" do
    evaluate(" (+ 1\n 2 (+\r 2 3)\t (- 5   1   )) ").should == 12
  end
end
