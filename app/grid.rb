class Grid
  attr_accessor :lost_positions
  def initialize(x, y)
    @min_x = 0
    @min_y = 0
    @max_x, @max_y = x.to_i, y.to_i
    @lost_positions = []
  end

  def moveable?(position)
    position.x_pos.between?(@min_x, @max_x) &&
    position.y_pos.between?(@min_y, @max_y)
  end

  def lost_scent?(position)
    !!lost_positions.detect {|l| l.x_pos == position.x_pos && l.y_pos == position.y_pos }
  end
end