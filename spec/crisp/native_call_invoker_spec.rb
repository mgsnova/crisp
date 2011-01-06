require 'spec_helper'

describe "NativeCallInvoker functionality" do
  include Crisp::SpecHelper

  it "executes ruby native String#reverse" do
    evaluate('(. reverse "foobar")').should == 'raboof'
  end

  it "executes ruby native Array#first" do
    evaluate('(. first [1 2 3])').should == 1
  end

  it "executes ruby native Array#first(n)" do
    evaluate('(. first [1 2 3] 2)').should == [1,2]
  end

  it "raises a named exception on invalid method" do
    lambda do
      evaluate('(. foo "bar")')
    end.should raise_error(NoMethodError, %q{undefined method `foo' for "bar":String})
  end

  it "executes calls on Ruby classes" do
    evaluate("(. new String)").should == ''
    evaluate('(. new String "123")').should == '123'
    evaluate("(. new Array 5 2)").should == [2, 2, 2, 2, 2]
  end
end
