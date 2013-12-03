require_relative "board"
require_relative "piece"

class InvalidMoveError < StandardError
  def initialize(msg = "There is an error here.")
    super
  end
end

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    while true
      p board
      puts "Enter a move(s)"
      input = convert_input(gets.chomp)
      start_x, start_y = input.shift
      self.board[start_x, start_y].perform_moves(input)
    end
  end

  def convert_input(str)
    str.split(";").map { |arr| arr.split(",").map(&:to_i)}
  end
end

#
# b = Board.new
# b[5, 1].perform_moves!([[4,2]])
# #b[5,1].perform_slide(4,2)
# p b
#
# #b[2,0].perform_slide(3,1)
# b[2, 0].perform_moves!([[3,1]])
# p b
#
# #b[4,2].perform_jump(2,0)
# b[4, 2].perform_moves!([[2,0]])
# p b
#
# #b[2,4].perform_slide(3,3)
# b[2, 4].perform_moves!([[3,3]])
# p b
#
# b[5, 3].perform_moves!([[4,2]])
# p b
#
# b[3, 3].perform_moves!([[5,1]])
# p b
#
# b[2, 2].perform_moves!([[3,3]])
# p b
#
#  # b[6,0].perform_moves([[4,2], [3,1]]) #incorrect move
#  # p b
#
# b[6,0].perform_moves([[4,2], [2,4]]) #correct move
# p b
