require 'spec_helper'

describe "internals" do
  include Crisp::SpecHelper

  it "should set and get values to and from the env" do
    env = Crisp::Env.new
    env['key'] = 'value'

    env['key'].should == 'value'
    env[:key].should == 'value'
    env.has_key?('key').should == true
    env.has_key?(:key).should == true
  end

  it "should handle mismatched env reads" do
    env = Crisp::Env.new

    env.has_key?('not_exists').should == false
    env['not_exists'].should == nil
  end

  it "should not allow to set env keys twice" do
    env = Crisp::Env.new
    env['key'] = 'value'

    lambda do
      env['key'] = 'another value'
    end.should raise_error(Crisp::EnvironmentError, "key already binded")
  end

  it "should get values from a chained env" do
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

  it "should set values to a chained env" do
    env1 = Crisp::Env.new
    env1[:key] = 'val'

    env2 = Crisp::Env.new

    chained = Crisp::ChainedEnv.new(env1, env2)

    chained[:key] = 'other'
    env2[:key].should == 'other'
    chained[:key].should == 'val'
  end

  it "should set aliases" do
    env = Crisp::Env.new
    env[:key] = 1
    env.alias(:alias, :key)
    env[:alias].should == 1
  end

  it "should set aliases to a chained env" do
    env1 = Crisp::Env.new
    env1[:key] = 1
    env2 = Crisp::Env.new

    env = Crisp::ChainedEnv.new(env1, env2)

    env[:key] = 1
    env.alias(:alias, :key)
    env[:alias].should == 1
  end

  if RUBY_VERSION >= "1.9.0"
    it "should have a lazy sequence" do
      seq = Crisp::Lazyseq.new do 
        number = 1
        loop do
          emit number
          number += 1
        end
      end

      seq.next.should be 1
      seq.next.should be 2
      seq.next.should be 3
      seq.next.should be 4
      seq.next.should be 5
    end
  end
end
