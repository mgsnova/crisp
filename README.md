# Crisp

Crisp is an experimental language written in Ruby, using treetop.

Crisp has a Lisp syntax and immutable data structures.

The main purpose of the language is to deal with the issues and problems when creating your own programming language.

## Language features

 *   binding values to a symbol with **def**
 *   calculations with **+**, **-**, __*__ and __/__
 *   comparisons with **>**, **<** and **=**
 *   conditional statements with **if**
 *   loop statements with **loop**/**recur**
 *   console output with **println**
 *   function creation with **fn**
 *   switch/case conditions with **cond**
 *   local binding with **let**
 *   dynamic loading of crisp source files with **load**
 *   head and tail functions for array with **head** and **tail**
 *   calling native ruby with **.**

## Example

        # crisp
        >> (println "Hello World")
        Hello World
        =>
        >> (def fib (
        ?>   fn [n]
        ?>     (if (< n 2)
        ?>       n
        ?>         (+ (fib (- n 1)) (fib (- n i))))))
        => #<Crisp::Function:0x1005c2500>
        >> (fib 10)
        => 55
        >> (def factorial
        ?>   (fn [n]
        ?>     (loop [cnt n acc 1]
        ?>       (if (= 0 cnt)
        ?>         acc
        ?>         (recur (- cnt 1) (* acc cnt))))))
        => #<Crisp::Function:0x1001ad9d8>
        >> (factorial 12)
        => 479001600

## Installation

        gem install crisp

## Usage

To start an interactive shell:
        crisp

To run a crisp programm
        crisp /path/to/file
