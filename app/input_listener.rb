class InputListener

  def run
    @running = true
    @count = 0
    puts 'type ? for help'
    while @running
      print '> '
      command = $stdin.gets.chomp

      if command == 'X'
        exit_console
      else
        args = command.scan(/-?\w+/)
        @grid = Grid.new(*args) if @count == 0
        if set_initial_position?
          @robot = Robot.new(@grid)
          @robot.set_position(*args)
        elsif move_robot?
          @robot.obey(args.first)
        end
      end

      @count += 1
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def set_initial_position?
      (@count%2) == 1
    end

    def move_robot?
      (@count%2) == 0 && @count != 0
    end
end
