require 'spec_helper'

describe "the language sequence features" do
  include Crisp::SpecHelper

  if RUBY_VERSION >= "1.9.0"
    it "should raises an error when calling next with wrong arguments" do
      lambda do
        evaluate("(next 1 2)")
      end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'next' (2 for 1)")

      lambda do
        evaluate("(next)")
      end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'next' (0 for 1)")
    end

    it "should raises an error when calling next with a non sequence parameter" do
      lambda do
        evaluate("(next 1)")
      end.should raise_error(Crisp::ArgumentError, "argument is not a sequence")
    end

    it "should raise an error when calling emit with wrong number of arguemtns" do
      lambda do
        evaluate("(def seqtest (lazyseq
                    (loop [cnt 1]
                      (emit)
                      (recur (+ cnt 1)))))
                  (next seqtest)")
      end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'emit' (0 for 1)")

      lambda do
        evaluate("(def seqtest (lazyseq
                    (loop [cnt 1]
                      (emit cnt cnt)
                      (recur (+ cnt 1)))))
                  (next seqtest)")
      end.should raise_error(Crisp::ArgumentError, "wrong number of arguments for 'emit' (2 for 1)")
    end

    it "should not be possible to call emit outside of a sequence" do
      lambda do
        evaluate("(emit 1)")
      end.should raise_error(NoMethodError)
    end

    it "should create an empty lazy sequence" do
      lambda do
        evaluate("(next (lazyseq))")
      end.should raise_error(StopIteration, "iteration reached an end")
    end

    it "should have lazy sequences" do
      evaluate("(def seqtest (lazyseq
                  (loop [cnt 1]
                    (emit cnt)
                    (recur (+ cnt 1)))))
                (next seqtest)
                (next seqtest)
                (next seqtest)
                (next seqtest)
                (next seqtest)
      ").should == 5
    end

    it "should take n values from a sequence with take" do
      evaluate("(def seqtest (lazyseq
                  (loop [cnt 1]
                    (emit cnt)
                    (recur (+ cnt 1)))))
                (take 5 seqtest)
      ").should == [1,2,3,4,5]
    end

    it "should return the nth value from a sequence with nth" do
      evaluate("(def seqtest (lazyseq
                  (loop [cnt 1]
                    (emit cnt)
                    (recur (+ cnt 1)))))
                (nth 5 seqtest)
      ").should == 5
    end
  else
    it "should raise an error when using lazy sequences on ruby < 1.9.0" do
      lambda do
        evaluate("(def seqtest (lazyseq
                    (loop [cnt 1]
                      (emit cnt)
                      (recur (+ cnt 1)))))
                  (take 5 seqtest)")
      end.should raise_error(RuntimeError, "To use lazy sequences ruby >=1.9.0 is required")
    end
  end
end

