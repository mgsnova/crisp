require 'spec_helper'

describe "the languages functions" do
  include Crisp::SpecHelper

  it "should not create a function when providing wrong number of arguments" do
    lambda do
      evaluate("(fn [] (+ 1 2) [])")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'fn' (3 for 2)")
  end

  it "should not create a function when not providing a proper argument list" do
    lambda do
      evaluate("(fn (+ 2 1) (+ 1 2))")
    end.should raise_error(Crisp::ArgumentError, "no argument list defined")
  end

  it "should return primitive values as result" do
    evaluate("((fn [] 1))").should == 1
    evaluate('((fn [] "abc"))').should == 'abc'
    evaluate('((fn [] [1 2 3]))').should == [1, 2, 3]
    evaluate("((fn [x] x) 2)").should == 2
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

  it "should call functions with arguments" do
    evaluate("(def myfn (fn [a b] (+ a b)))(myfn 5 2)").should == 7
  end

  it "should not call functions with wrong number of arguments" do
    lambda do
      evaluate("(def myfn (fn [a1 a2 a3] (+ 1 1)))(myfn 1)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'myfn' (1 for 3)")
  end

  it "should instantly evaluate a function" do
    evaluate("((fn [] (+ 1 2)))").should == 3
  end
end
