class Game
  include Constants

  def initialize
    @ball_x = 10
    @ball_y = 10
    @score = 0
    @finished = false
  end

  def draw
    Square.new(x: @ball_x * SQUIRE_SIZE, y: @ball_y * SQUIRE_SIZE, size: SQUIRE_SIZE, color: 'yellow')
    Text.new(text_message, color: 'green', x: 10, y: 10, size: 25, z: 1)
  end

  def snake_hit_ball?(x, y)
    @ball_x == x && @ball_y == y
  end

  def record_hit
    @score += 1
    @ball_x = rand(Window.width / SQUIRE_SIZE)
    @ball_y = rand(Window.height / SQUIRE_SIZE)
  end

  def finish
    @finished = true
  end

  def finished?
    @finished
  end

  private

  def text_message
    if finished?
      "Game over, Your Score was #{@score}. Press 'R' to restart. "
    else
      "Score: #{@score}"
    end
  end
end