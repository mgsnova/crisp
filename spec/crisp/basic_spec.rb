require 'spec_helper'

describe "the language" do
  include Crisp::SpecHelper

  it "does not bother whitspace characters in expressions" do
    evaluate(" \r\t\n (\r+\t 1\n2 \t(\n - 9\r\t  \n   2)\r)\r\t   ").should == 10
  end

  it "raises a syntax error on invalid expressions" do
    lambda do
      evaluate("(()")
    end.should raise_error(Crisp::SyntaxError, "syntax error at : 0")
  end

  it "binds arrays to symbols" do
    evaluate("(def bla [1 2 3])").size.should == 3
    evaluate("(def bla [1 2 3])")[1].should == 2
    evaluate("(def foo 5)(def bla [1 2 foo])")[2].should == 5
  end

  it "does not evaluate numbers" do
    lambda do
      evaluate("(3)")
    end.should raise_error(Crisp::SyntaxError, "syntax error at : 0")
  end
end
