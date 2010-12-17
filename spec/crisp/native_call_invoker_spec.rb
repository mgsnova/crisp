require 'spec_helper'

describe "NativeCallInvoker functionality" do
  include Crisp::SpecHelper

  it "should execute String#reverse probably" do
    evaluate('(. reverse "foobar")').should == 'raboof'
  end

  it "should execute Array#first probably" do
    evaluate('(. first [1 2 3])').should == 1
  end

  it "should execute Array#first(n) probably" do
    evaluate('(. first [1 2 3] 2)').should == [1,2]
  end

  it "should raise a named exception on invalid method" do
    lambda do
      evaluate('(. foo "bar")')
    end.should raise_error(NoMethodError, %q{undefined method `foo' for "bar":String})
  end
end
