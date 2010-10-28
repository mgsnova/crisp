require 'spec_helper'

describe "the language" do
  include Crisp::SpecHelper

  it "should not bother whitespaces, tabs and linebreaks in statements" do
    evaluate(" \r\t\n (\r+\t 1\n2 \t(\n - 9\r\t  \n   2)\r)\r\t   ").should == 10
  end

  it "should print results" do
    evaluate("(println (+ 1 1))")
  end

  it "should bind variables to symbols" do
    evaluate("(def bla 3)")
  end

  it "should raise error if use def with wrong args" do
    lambda do
      evaluate("(def bla 1 2)")
    end.should raise_error(StandardError, "wrong number of arguments for 'def' (3 for 2)")
  end
end
