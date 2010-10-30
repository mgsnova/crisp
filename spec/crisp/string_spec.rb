require 'spec_helper'

describe "when evaluating string expressions, the language" do
  include Crisp::SpecHelper

  it "should concat strings" do
    evaluate('(+ "foo" "bar")').should == 'foobar'
  end

end
