require 'spec_helper'

describe "the language" do
  include Crisp::SpecHelper

  it "should not bother whitespaces, tabs and linebreaks in statements" do
    evaluate(" \r\t\n (\r+\t 1\n2 \t(\n - 9\r\t  \n   2)\r)\r\t   ").should == 10
  end

  it "should print results" do
    evaluate("(println (+ 1 1))")
  end

  it "should bind value to symbol" do
    evaluate("(def bla 3)")
  end

  it "should not bind value to already binded symbol" do
    lambda do
      evaluate("(def def 123)")
    end.should raise_error(Crisp::EnvironmentError, "def already binded")
  end

  it "should raise error if use def with wrong args" do
    lambda do
      evaluate("(def bla 1 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'def' (3 for 2)")
  end

  it "should evaluate a list of operations" do
    lambda do
      evaluate("(+ 1 2) (def foo 1) (def foo 2)")
    end.should raise_error(Crisp::EnvironmentError, "foo already binded")
  end

  it "should produce syntax error on invalid syntax" do
    lambda do
      evaluate("(()")
    end.should raise_error(Crisp::SyntaxError, "syntax error at : 0")
  end

  it "should use values of binded symbols in later statements" do
    evaluate("(def bla 2) (* 4 bla)").should == 8
    evaluate("(def bla (* 2 3)) (* 4 bla 2)").should == 48
  end

  it "should parse an array" do
    evaluate("(def bla [1 2 3])").size.should == 3
    evaluate("(def bla [1 2 3])")[1].should == 2
    evaluate("(def bla [1 2 foo])")[2].should == :foo
  end
end
