# -*- coding: utf-8 -*-
class Board
	BLANK = "_|"
  attr_accessor :grid

	def initialize
		fill_board
	end

	def display
    disp = ""
		@grid.map do |row|
      disp += "\n"
			row.map do |piece|
        disp += piece.nil? ? BLANK : piece.render
			end
    end

    puts disp
	end

	def fill_board
		@grid = Array.new(8) {Array.new(8)}

		8.times do |row|
			8.times do |col|
				if (row+col)%2 == 0 && row < 3
					@grid[row][col] = Piece.new(self, [row, col], :black)
				elsif (row+col)%2 == 0 && row > 4
					@grid[row][col] = Piece.new(self, [row, col], :white)
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

	def symbols
		{ :white => '♙|', :black => '♟|' }
	end

	def perform_slide

	end

	def perform_jump

	end

	def move_diffs

	end

	def render
		symbols[color]
	end
end