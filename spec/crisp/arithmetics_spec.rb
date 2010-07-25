require 'spec_helper'

describe "when evaluating arithmetic expressions, the language" do

  include Crisp::SpecHelper

  before(:each) do
    @runtime = Crisp::Runtime.new
  end

  it "should calculate integer addition" do
    evaluate("(+ 1 2)").should == 3
    evaluate("(+ 12 13 1 5)").should == 31
  end

  it "should calculate integer substraction" do
    evaluate("(- 3 1)").should == 2
    evaluate("(- 14 1 4 8)").should == 1
    evaluate("(- 2 5)").should == -3
  end

  it "should calculate integer multiplications" do
    evaluate("(* 2 3)").should == 6
    evaluate("(* 0 3)").should == 0
    evaluate("(* 2 3 1 10)").should == 60
  end

  it "should calculate integer divisions" do
    evaluate("(/ 12 3)").should == 4
    evaluate("(/ 48 2 12)").should == 2
  end

  it "should calculate nested arithmetic expressions" do
    evaluate("(+ 1 2 (+ 2 3) (- 5 1)) ").should == 12
    evaluate("(+ 1 2 (* 2 3) (/ 10 2)) ").should == 14
    evaluate("(+ 1 2 (- 10 2 3) (* 1 2 3) (/ 12 4)) ").should == 17
    evaluate("(/ 20 2 (+ 2 3) (- 5 3)) ").should == 1
  end
end
