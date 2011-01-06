require 'spec_helper'

describe "string functionality" do
  include Crisp::SpecHelper

  it "concats strings" do
    evaluate('(+ "foo" "bar")').should == 'foobar'
  end
end
