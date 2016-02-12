class Robot
  DIRECTION = %w(N E S W)
  attr_accessor :current_direction, :position

  def initialize(grid)
    @grid = grid
    @lost = false
  end

  def set_position(x_pos, y_pos, direction)
    @position = Position.new(x_pos, y_pos)
    @current_direction = direction
  end

  def obey(command)
    commands = command.scan(/./)

    commands.each do |c|
      unless send(commands_map(c))
        @grid.lost_positions << @position
        @lost = true
        break
      end
    end
    puts "#{@position.x_pos} #{@position.y_pos} #{@current_direction} #{'LOST' if @lost}"
  end

  private

  def turn_left
    @current_direction = rotate('left')
  end

  def turn_right
    @current_direction = rotate('right')
  end

  def move_forward
    if @grid.moveable?(new_position)
      @position = new_position
    elsif @grid.lost_scent?(@position)
      @position
    end
  end

  def new_position
    x_pos = @position.x_pos
    y_pos = @position.y_pos
    case @current_direction
    when 'N' then Position.new(x_pos, y_pos + 1)
    when 'E' then Position.new(x_pos + 1, y_pos)
    when 'S' then Position.new(x_pos, y_pos - 1)
    when 'W' then Position.new(x_pos - 1, y_pos)
    end
  end

  def rotate(direction)
    current_index = DIRECTION.index(@current_direction)
    case direction
    when 'left'   then DIRECTION.rotate(-1)[current_index]
    when 'right'  then DIRECTION.rotate[current_index]
    end
  end

  def commands_map(command)
    {
      'L' => 'turn_left',
      'R' => 'turn_right',
      'F' => 'move_forward'
    }.fetch(command)
  end
end