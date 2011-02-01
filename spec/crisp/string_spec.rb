require 'spec_helper'

describe "string functionality" do
  include Crisp::SpecHelper

  it "should concat strings" do
    evaluate('(+ "foo" "bar")').should == 'foobar'
  end
end
