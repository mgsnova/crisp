require 'spec_helper'

describe "the language" do
  include Crisp::SpecHelper

  it "should not bother whitespaces, tabs and linebreaks in statements" do
    evaluate(" \r\t\n (\r+\t 1\n2 \t(\n - 9\r\t  \n   2)\r)\r\t   ").should == 10
  end

  it "should be able to print results" do
    evaluate("(println (+ 1 1))")
  end
end
