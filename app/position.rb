class Position
  attr_accessor :x_pos, :y_pos
  def initialize(x, y)
    @x_pos, @y_pos = x.to_i, y.to_i
  end
end