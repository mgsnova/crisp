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
 *   calling native ruby with **.**

## Example

        # crisp
        >> (* 2 3)
        => 6
        >> (def foo 4)
        => 4
        >> (/ (* foo foo) 2 2)
        => 4
        >> (def add2 (fn [arg] (+ 2 arg)))
        => #<Crisp::Function:0x85d1bc0>
        >> (add2 5)
        => 7

## Installation

        gem install crisp

## Usage

To start an interactive shell:
        crisp

To run a crisp programm
        crisp /path/to/file
