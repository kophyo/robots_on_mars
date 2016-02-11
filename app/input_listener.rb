class InputListener

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = $stdin.gets.chomp

      args = input.split
      if input == 'X'
        exit_console
      end
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end
end
