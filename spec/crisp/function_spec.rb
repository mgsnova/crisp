require 'spec_helper'

describe "the languages functions" do
  include Crisp::SpecHelper

  it "does not create a function when providing wrong number of arguments" do
    lambda do
      evaluate("(fn [] (+ 1 2) [])")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'fn' (3 for 2)")
  end

  it "does not create a function when not providing a proper argument list" do
    lambda do
      evaluate("(fn (+ 2 1) (+ 1 2))")
    end.should raise_error(Crisp::ArgumentError, "no argument list defined")
  end

  it "does not create a function when not providing a proper function body" do
    lambda do
      evaluate("(fn [] [])")
    end.should raise_error(Crisp::ArgumentError, "no function body defined")
  end

  it "creates functions" do
    evaluate("(fn [arg] (+ 2 arg))")
  end

  it "binds functions to symbols" do
    evaluate("(def myfn (fn [arg] (+ 1 arg)))").class.name.should == "Crisp::Function"
  end

  it "calls functions" do
    evaluate("(def myfn (fn [a b] (+ 1 1)))(myfn 1 2)").should == 2
  end

  it "calls functions with arguments" do
    evaluate("(def myfn (fn [a b] (+ a b)))(myfn 5 2)").should == 7
  end

  it "does not calls functions with wrong number of arguments" do
    lambda do
      evaluate("(def myfn (fn [a1 a2 a3] (+ 1 1)))(myfn 1)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'myfn' (1 for 3)")
  end
end
