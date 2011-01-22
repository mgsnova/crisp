require 'spec_helper'

describe "the language array features" do
  include Crisp::SpecHelper

  it "raises error on wrong number of arguments for head" do
    lambda do
      evaluate("(head)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'head' (0 for 1)")

    lambda do
      evaluate("(head 1 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'head' (2 for 1)")
  end

  it "raises error on invalid argument for head" do
    lambda do
      evaluate("(head 3)")
    end.should raise_error(Crisp::ArgumentError, "argument is not an array")
  end

  it "calculates the head of an array" do
    evaluate("(head [1 2 3])").should == 1
    evaluate("(head [2])").should == 2
    evaluate("(head [])").should == nil
  end

  it "raises error on wrong number of arguments for tail" do
    lambda do
      evaluate("(tail)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'tail' (0 for 1)")

    lambda do
      evaluate("(tail 1 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'tail' (2 for 1)")
  end

  it "raises error on invalid argument for tail" do
    lambda do
      evaluate("(tail 3)")
    end.should raise_error(Crisp::ArgumentError, "argument is not an array")
  end

  it "calculates the tail of an array" do
    evaluate("(tail [1 2 3])").should == [2, 3]
    evaluate("(tail [2])").should == []
    evaluate("(tail [])").should == []
  end
end
