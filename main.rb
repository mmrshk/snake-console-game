require 'ruby2d'
require 'pry'
require 'bundler/inline'

require_relative 'modules/constants'
require_relative 'game.rb'
require_relative 'snake.rb'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
  gem 'ruby2d'
end

set title: 'Snake game', background: 'navy', resizable: true

snake = Snake.new
game = Game.new

update do
  clear
  snake.move unless game.finished?

  snake.draw
  game.draw
   
  if game.snake_hit_ball?(snake.x, snake.y)
    game.record_hit
    snake.grow
  end

  game.finish if snake.hit_itself? 
end


on :key_down do |event|
  if %w[up down left right].include?(event.key)
    if snake.can_change_direction_to?(event.key)
      snake.direction = event.key
    end
  end

  if game.finished? && event.key == 'r'
    snake = Snake.new
    game = Game.new
  end
end

show