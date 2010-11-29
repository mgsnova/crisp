## Crisp

Crisp is an experimental language written in Ruby, using treetop.

Crisp has a Lisp syntax and immutable data structures.

The main purpose of the language is to deal with the issues and problems when creating your own programming language.

### Example

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

### Installation

        gem install crisp

### Usage

To start an interactive shell:
        crisp

To run a crisp programm
        crisp /path/to/file
