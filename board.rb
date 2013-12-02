# -*- coding: utf-8 -*-
class Board
	BLANK = "_|"
  attr_accessor :grid

	def initialize
		fill_board
	end

  def [](x, y)
    self.grid[x][y]
  end

  def []=(x, y, piece)
    self.grid[x][y] = piece
  end

  def display
    disp = ""
		self.grid.each do |row|
      disp += "\n"
			row.each do |piece|
        disp += piece.nil? ? BLANK : piece.render
			end
    end

    puts disp
	end

  def empty?(x, y)
    self.grid[x][y].nil?

  end

	def fill_board
		self.grid = Array.new(8) {Array.new(8)}

		8.times do |row|
			8.times do |col|
				if (row+col)%2 == 0 && row < 3
					self.grid[row][col] = Piece.new(self, [row, col], :black)
				elsif (row+col)%2 == 0 && row > 4
					self.grid[row][col] = Piece.new(self, [row, col], :white)
				end
			end
		end
	end


end


class Piece
	attr_reader :color, :board
	attr_accessor :position

	def initialize(board, position, color)
		@board = board
		@position = position
		@color = color
	end

  def move_diffs
    color == :white ? [[-1, -1], [1, -1]] : [[-1, 1], [1, 1]]
	end

  def friendly_color?(destination_x, destination_y)
    self.color == board[destination_x, destination_y].color
  end

	def perform_jump(destination_x, destination_y)
    raise "Invalid move" if !valid_jump_pos?(destination_x, destination_y)
      current_x, current_y = position
      if check_for_piece(destination_x, destination_y)
	end

	def perform_slide(destination_x, destination_y)
    raise "Invalid move" if !valid_pos?(destination_x, destination_y)
    raise "Already a piece there." if !board.empty?(destination_x, destination_y)
    current_x, current_y = position
     board[destination_x, destination_y] = self
     self.position = [destination_x, destination_y]
     board[current_x, current_y] = nil
	end

	def render
		symbols[color]
	end

	def symbols
		{ :white => '♙|', :black => '♟|' }
	end

  def valid_jump_pos?(destination_x, destination_y)
    current_x, current_y = position
    move_diffs.each do |dx, dy|
      if (current_x + dx + dx == destination_x) && (current_y + dy + dy == destination_y)
        return true
      end
    end
    false
  end

  def valid_pos?(destination_x, destination_y)
    current_x, current_y = position
    move_diffs.each do |dx, dy|
      if (current_x + dx == destination_x) && (current_y + dy) == destination_y
        return true
      end
    end
    false
  end

end