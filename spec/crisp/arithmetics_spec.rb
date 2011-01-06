require 'spec_helper'

describe "arithemtic functions" do
  include Crisp::SpecHelper

  it "adds integer values" do
    evaluate("(+ 1 2)").should == 3
    evaluate("(+ 12 13 1 5)").should == 31
    evaluate("(+ 12 13 -1 -5)").should == 19
  end

  it "substracts integer values" do
    evaluate("(- 3 1)").should == 2
    evaluate("(- 14 1 4 8)").should == 1
    evaluate("(- 2 5)").should == -3
    evaluate("(- 2 -5)").should == 7
  end

  it "multiplies integer values" do
    evaluate("(* 2 3)").should == 6
    evaluate("(* 0 3)").should == 0
    evaluate("(* 2 -3 1 10)").should == -60
  end

  it "divides integer values" do
    evaluate("(/ 12 3)").should == 4
    evaluate("(/ 48 2 12)").should == 2
    evaluate("(/ 30 -3 2)").should == -5
  end

  it "calculates different nested operations" do
    evaluate("(+ 1 2 (+ 2 3) (- 5 1)) ").should == 12
    evaluate("(+ 1 2 (* 2 3) (/ 10 2)) ").should == 14
    evaluate("(+ 1 2 (- 10 2 3) (* 1 2 3) (/ 12 4)) ").should == 17
    evaluate("(/ 20 2 (+ 2 3) (- 5 3)) ").should == 1
  end

  it "adds float values" do
    evaluate("(+ 1.0 2.)").should == 3.0
    evaluate("(+ 12.5 13 1.4 5)").should == 31.9
    evaluate("(+ 12. 13.5 -1.9 -5.1)").should == 18.5
  end

  it "substracts float values" do
    evaluate("(- 3. 1.4)").should == 1.6
    evaluate("(- 2 5.5)").should == -3.5
    evaluate("(- 2.40 -5)").should == 7.4
  end

  it "multiplies float values" do
    evaluate("(* 2.1 3.4)").should == 7.14
    evaluate("(* 0 3.5)").should == 0
    evaluate("(* 2 -3.1 1.9 10.1)").should == -118.978
  end

  it "divides float values" do
    evaluate("(/ 12.5 3.1)").should be_within(0.0000001).of(4.03225806451613)
    evaluate("(/ 48 2.000 12.5)").should == 1.92
    evaluate("(/ 30.0 -3 2.5)").should == -4.0
  end

  it "calculates different nested operations" do
    evaluate("(+ 1 2.3 (* 2 3.5) (/ 10 4)) ").should == 12.3
    evaluate("(+ 1.5 2 (- 10 2.4 3) (* 1.0 2 3) (/ 12 3.0)) ").should == 18.1
    evaluate("(/ 20.4 2 (+ 2.5 3) (- 5.5 3)) ").should be_within(0.000000001).of(0.741818181818182)
  end

  it "compares values for equality" do
    evaluate("(= 1 1)").should == true
    evaluate("(= 1 2)").should == false
  end

  it "compares values that are greater than others" do
    evaluate("(> 2 1)").should == true
    evaluate("(> 1 1)").should == false
    evaluate("(> 1 2)").should == false
  end

  it "compares values that are less than others" do
    evaluate("(< 2 1)").should == false
    evaluate("(< 1 1)").should == false
    evaluate("(< 1 2)").should == true
  end

  it "calculates fibonacci numbers" do
    evaluate("
      (def fib (
        fn [n]
        (if (< n 2)
          n
          (+ (fib (- n 1)) (fib (- n 2))))))
      (fib 10)
    ").should == 55
  end
end
