module Crisp
  class Shell
    require 'readline'

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
