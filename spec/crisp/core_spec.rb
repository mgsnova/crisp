require 'spec_helper'

describe "the core language features" do
  include Crisp::SpecHelper

  it "should print results" do
    evaluate("(println (+ 1 1))")
  end

  it "should bind values to symbols" do
    evaluate("(def bla 3)")
  end

  it "should not allow to bind symbols twice" do
    lambda do
      evaluate("(def name 123)(def name 123)")
    end.should raise_error(Crisp::EnvironmentError, "name already binded")
  end

  it "should produce an error when calling bind function with arguments" do
    lambda do
      evaluate("(def bla 1 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'def' (3 for 2)")
  end

  it "should use binded values in later expressions" do
    evaluate("(def bla 2) (* 4 bla)").should == 8
    evaluate("(def bla (* 2 3)) (* 4 bla 2)").should == 48
  end

  it "should not resolve unbound symbols" do
    lambda do
      evaluate("n")
    end.should raise_error(Crisp::EnvironmentError, "n is unbound")
  end

  it "should resolve primitve types" do
    evaluate("2").should == 2
    evaluate("2.1").should == 2.1
    evaluate("nil").should == nil
    evaluate("true").should == true
    evaluate("false").should == false
    evaluate('"abc"').should == 'abc'
    evaluate("[1 2 3]").should == [1, 2, 3]
  end

  it "should resolve bounded symbols" do
    evaluate("(def foo 23) foo").should == 23
    evaluate('(def foo "foo") foo').should == 'foo'
  end

  it "should bind symbols to value of already bound symbol" do
    evaluate("(def a 1)
              (def b a)
              b").should == 1
  end

  it "should evaluate if statements" do
    evaluate("(if true 1)").should == 1
    evaluate("(if false 1)").should == nil
    evaluate("(if nil 1)").should == nil
  end

  it "should evaluate if else statements" do
    evaluate("(if true 1 2)").should == 1
    evaluate("(if false 1 2)").should == 2
    evaluate("(if nil 1 2)").should == 2
  end

  it "should not run if statements with wrong number of arguments" do
    lambda do
      evaluate("(if true true false 2)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'if' (4 for 2..3)")

    lambda do
      evaluate("(if true)")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'if' (1 for 2..3)")
  end

  it "should resolve symbols in if statements" do
    evaluate("(def foo 2)(if true foo)").should == 2
  end

  it "should use local binding with let" do
    evaluate("(let [x 1] x)").should == 1
  end

  it "should use more complex local bindings with let" do
    evaluate("(let [x 2 y x] (* x y))").should == 4
  end

  it "should evaluate several expressions within local binding" do
    evaluate("(let [x 2 y 3] (* x y) (+ x y))").should == 5
  end

  it "should bind symbols to global binding within local binding" do
    evaluate("(let [x 1 y 2] (def foo (+ x y))) foo").should == 3
  end

  it "should override global binding within local binding" do
    evaluate("(def x 1)(let [x 2] x)").should == 2
  end

  it "should ensure that local binding is only valid within let" do
    evaluate("(def x 1)(let [x 2] x) x").should == 1
  end

  it "should handle emtpy local binding" do
    evaluate("(let [] 2)").should == 2
  end

  it "should raise an error when calling let without correct argument" do
    lambda do
      evaluate("(let 2 2)")
    end.should raise_error(Crisp::ArgumentError, "no argument list defined")
  end

  it "should raise an error when calling let with odd binding list" do
    lambda do
      evaluate("(let [x 1 y] 2)")
    end.should raise_error(Crisp::ArgumentError, "argument list has to contain even list of arguments")
  end

  it "should raise an error if file to be load not there" do
    lambda do
      evaluate('(load "not_there")')
    end.should raise_error(Crisp::ArgumentError, /file (.*) not found/)

    lambda do
      evaluate('(load "/not_there")')
    end.should raise_error(Crisp::ArgumentError, "file /not_there.crisp not found")
  end

  it "should load other crisp files" do
    File.open("/tmp/crisp_test_file.crisp", 'w') do |f|
      f << "(def foo 123)"
    end

    evaluate('(load "/tmp/crisp_test_file")(+ 1 foo)').should == 124
  end

  it "should use the current environment when loading other crisp source files" do
    File.open("/tmp/crisp_test_file.crisp", 'w') do |f|
      f << "(def bla 123)"
    end

    lambda do
      evaluate('(def bla 321)(load "/tmp/crisp_test_file")')
    end.should raise_error(Crisp::EnvironmentError, "bla already binded")
  end

  it "should raise an error if calling cond with wrong number of arguments" do
    lambda do
      evaluate("(cond false 1 true)")
    end.should raise_error(Crisp::ArgumentError, "argument list has to contain even list of arguments")
  end

  it "should evaluate cond statement" do
    evaluate("(cond)").should == nil
    evaluate("(cond false 1 false 2)").should == nil
    evaluate("(cond true 3)").should == 3
    evaluate("(cond true 3 false 2)").should == 3
    evaluate("(cond false 3 true 2)").should == 2
    evaluate("(cond (= 1 1) (+ 1 1))").should == 2
    evaluate("(cond true 3 true 2 true 1)").should == 3
  end

  it "should not eval expressions for unmatched condition" do
    evaluate("(cond false (def foo 1) true 2)(def foo 2) foo").should == 2
  end

  it "should have a default condition in cond" do
    evaluate("(cond false 1 true 2 else 3)").should == 2
    evaluate("(cond true 1 true 2 else 3)").should == 1
    evaluate("(cond false 1 else 2 true 3)").should == 2
  end

  it "should raise an error when calling loop without correct argument" do
    lambda do
      evaluate("(loop 2 2)")
    end.should raise_error(Crisp::ArgumentError, "no argument list defined")
  end

  it "should raise an error when calling loop with odd binding list" do
    lambda do
      evaluate("(loop [x 1 y] 2)")
    end.should raise_error(Crisp::ArgumentError, "argument list has to contain even list of arguments")
  end

  it "should raise an error when calling recur outside a loop" do
    lambda do
      evaluate("(recur 1)")
    end.should raise_error(Crisp::LoopError, "recur called outside loop")
  end

  it "should raise an error when calling recur with wrong number of arguments" do
    lambda do
      evaluate("(loop [x 1] (recur 1 2))")
    end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'recur' (2 for 1)")
  end

  it "should calculate factorials using loop recur" do
    evaluate("
      (def factorial
        (fn [n]
          (loop [cnt n acc 1]
            (if (= 0 cnt)
              acc
              (recur (- cnt 1) (* acc cnt))))))
      (factorial 5)
    ").should == 120
  end

  it "should raise an error when nesting loops" do
    lambda do
      evaluate("(loop [x 1] (loop [a 1 b 2] (+ a b)))")
    end.should raise_error(Crisp::LoopError, "nested loops are not allowed")
  end

  it "should create an alias to a function symbol" do
    evaluate("(alias fed def) (fed a 1) a").should == 1 
  end

  it "should create an alias to a value symbol" do
    evaluate("(def foo 123) (alias bar foo) foo").should == 123
  end
end
