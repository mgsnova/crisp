module Crisp
  class Shell
    def run
      runtime = Crisp::Runtime.new
      buffer = ''

      loop do
        print ">> " if buffer.empty?
        buffer << gets

        if ast = Crisp::Parser.new.parse(buffer)
          puts "=> " + runtime.run(ast).to_s
          buffer = ''
        else
          print "?> "
        end
      end
    end
  end
end
