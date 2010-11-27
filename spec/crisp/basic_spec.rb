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

  it "should raise error if not providing right amount of parameters for function creation" do
    lambda do
      evaluate("(fn [] (+ 1 2) [])")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'fn' (3 for 2)")
  end

  it "should raise error if not providing proper argument list for function generation" do
    lambda do
      evaluate("(fn (+ 2 1) (+ 1 2))")
    end.should raise_error(Crisp::ArgumentError, "no parameter list defined")
  end

  it "should raise error if not providing proper function body" do
    lambda do
      evaluate("(fn [] [])")
    end.should raise_error(Crisp::ArgumentError, "no function body defined")
  end

  it "should create functions" do
    evaluate("(fn [arg] (+ 2 arg))")
  end

  it "should bind functions to symbols" do
    evaluate("(def myfn (fn [arg] (+ 1 arg)))").class.name.should == "Crisp::Function"
  end

  it "should call functions" do
    evaluate("(def myfn (fn [a b] (+ 1 1)))(myfn 1 2)").should == 2
  end

  it "should use parameters when calling functions" do
    evaluate("(def myfn (fn [a b] (+ a b)))(myfn 5 2)").should == 7
  end

  it "should raise error on wrong amount of parameters" do
    lambda do
      evaluate("(def myfn (fn [a1 a2 a3] (+ 1 1)))(myfn 1)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for '' (1 for 3)")
  end
end
