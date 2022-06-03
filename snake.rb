class Snake
  include Constants

  attr_accessor :direction, :positions

  POSITIONS = {
    up: 'up',
    down: 'down',
    left: 'left',
    right: 'right'
  }.freeze

  def initialize
    @positions = [[1,0], [1,1],[1,2],[1,3]]
    @direction = POSITIONS[:down]
    @growing = false
  end

  def draw
    positions.each do |position| 
      Square.new(x: position[0] * SQUIRE_SIZE, y: position[1] * SQUIRE_SIZE, size: SQUIRE_SIZE - 1, color: 'white')
    end
  end

  def grow
    @growing = true
  end

  def move
    positions.shift if !@growing

    positions.push(next_position)
    @growing = false
  end

  def can_change_direction_to?(new_direction)
    case direction
    when POSITIONS[:up] then new_direction != POSITIONS[:down]
    when POSITIONS[:down] then new_direction != POSITIONS[:up]
    when POSITIONS[:left] then new_direction != POSITIONS[:right]
    when POSITIONS[:right] then new_direction != POSITIONS[:left]
    end
  end

  def hit_itself?
    positions.uniq.length != positions.length
  end

  def x 
    head[0]
  end

  def y
    head[1]
  end

  private 

  def next_position
    if direction == 'down'
      new_coords(x, y + 1)
    elsif direction == 'up'
      new_coords(x, y - 1)
    elsif direction == 'left'
      new_coords(x - 1, y)
    elsif direction == 'right'
      new_coords(x + 1, y)
    end
  end

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end
end