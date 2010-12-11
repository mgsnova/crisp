module Crisp
  # The Crisp interactive shell
  #
  # Create a new instance and call run for having a interactive Crisp shell.
  class Shell
    require 'readline'

    # start the shell
    def run
      runtime = Runtime.new
      buffer = ''

      while (line = Readline.readline(buffer.empty? ? ">> " : "?> ", true))
        begin
          buffer << line
          ast = Parser.new.parse(buffer)
          puts "=> " + runtime.run(ast).to_s
          buffer = ''
        rescue Crisp::SyntaxError => e
          # noop
        end
      end
    end
  end
end
