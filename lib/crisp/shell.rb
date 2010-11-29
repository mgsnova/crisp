module Crisp
  class Shell
    require 'readline'

    def run
      runtime = Runtime.new

      while (line = Readline.readline(">> ", true))
        if ast = Parser.new.parse(line)
          puts "=> " + runtime.run(ast).to_s
        else
          print "?> "
        end
      end
    end
  end
end
