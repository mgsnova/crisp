require 'spec_helper'

describe "when evaluating arithmetic expressions, the language" do

  include Crisp::SpecHelper

  before(:each) do
    @runtime = Crisp::Runtime.new
  end

  it "should calculate integer addition" do
    evaluate("(+ 1 2)").should == 3
  end

  it "should calculate integer substraction" do
    evaluate("(- 3 1)").should == 2
  end

  it "should calculate nested arithmetic expressions" do
    evaluate("(+ 1 2 (+ 2 3) (- 5 1)) ").should == 12
  end
end
