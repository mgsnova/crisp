require 'spec_helper'

describe "the core language features" do
  include Crisp::SpecHelper

  it "prints results" do
    evaluate("(println (+ 1 1))")
  end

  it "binds values to symbols" do
    evaluate("(def bla 3)")
  end

  it "does not allow to bind symbols twice" do
    lambda do
      evaluate("(def name 123)(def name 123)")
    end.should raise_error(Crisp::EnvironmentError, "name already binded")
  end

  it "produces an error when calling bind function with arguments" do
    lambda do
      evaluate("(def bla 1 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'def' (3 for 2)")
  end

  it "uses binded values in later expressions" do
    evaluate("(def bla 2) (* 4 bla)").should == 8
    evaluate("(def bla (* 2 3)) (* 4 bla 2)").should == 48
  end

  it "can not resolve unbound symbols" do
    lambda do
      evaluate("n")
    end.should raise_error(Crisp::EnvironmentError, "n is unbound")
  end

  it "can resolve primitve types" do
    evaluate("2").should == 2
    evaluate("2.1").should == 2.1
    evaluate("nil").should == nil
    evaluate("true").should == true
    evaluate("false").should == false
    evaluate("\"abc\"").should == 'abc'
    evaluate("[1 2 3]").should == [1, 2, 3]
  end

  it "has if statements" do
    evaluate("(if true 1)").should == 1
    evaluate("(if false 1)").should == nil
    evaluate("(if nil 1)").should == nil
  end

  it "has if else statements" do
    evaluate("(if true 1 2)").should == 1
    evaluate("(if false 1 2)").should == 2
    evaluate("(if nil 1 2)").should == 2
  end

  it "does not run if statements with wrong number of arguments" do
    lambda do
      evaluate("(if true true false 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'if' (4 for 2..3)")

    lambda do
      evaluate("(if true)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'if' (1 for 2..3)")
  end

  it "resolves symbols in if statements" do
    evaluate("(def foo 2)(if true foo)").should == 2
  end
end
