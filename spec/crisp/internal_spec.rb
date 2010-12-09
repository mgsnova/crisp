require 'spec_helper'

describe "internals" do
  include Crisp::SpecHelper

  it "sets and gets values to and from the env" do
    env = Crisp::Env.new
    env['key'] = 'value'

    env['key'].should == 'value'
    env[:key].should == 'value'
    env.has_key?('key').should == true
    env.has_key?(:key).should == true
  end

  it "handles mismatched env reads" do
    env = Crisp::Env.new

    env.has_key?('not_exists').should == false
    env['not_exists'].should == nil
  end

  it "is not allowed to set env keys twice" do
    env = Crisp::Env.new
    env['key'] = 'value'

    lambda do
      env['key'] = 'another value'
    end.should raise_error(Crisp::EnvironmentError, "key already binded")
  end

  it "gets values from a chained env" do
    env1 = Crisp::Env.new
    env1[:key1] = 'val1'
    env1[:key2] = 'val2'

    env2 = Crisp::Env.new
    env2[:key1] = 'val3'
    env2[:key3] = 'val4'

    chained = Crisp::ChainedEnv.new(env1, env2)

    chained[:key1].should == 'val1'
    chained[:key2].should == 'val2'
    chained[:key3].should == 'val4'
  end

  it "sets values to a chained env" do
    env1 = Crisp::Env.new
    env1[:key] = 'val'

    env2 = Crisp::Env.new

    chained = Crisp::ChainedEnv.new(env1, env2)

    chained[:key] = 'other'
    env2[:key].should == 'other'
    chained[:key].should == 'val'
  end
end
