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
    disp = " \n\n 0 1 2 3 4 5 6 7"
		self.grid.each_with_index do |row, rowi|
      disp += "\n#{rowi}"
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

  def remove_piece(x, y)
    self.grid[x][y] = nil
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

  def check_for_piece(dx, dy)
    current_x, current_y = position
    piece_in_spot = board[current_x + dx, current_y + dy] != nil
    piece_different_color = board[current_x + dx, current_y + dy].color != self.color
    piece_in_spot && piece_different_color
  end


  def move_diffs
    color == :white ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
	end

  def friendly_color?(destination_x, destination_y)
    self.color == board[destination_x, destination_y].color
  end

	def perform_jump(destination_x, destination_y)
    raise "Invalid move" if !valid_jump_pos?(destination_x, destination_y)
    raise "Already a piece there." if !board.empty?(destination_x, destination_y)
      current_x, current_y = position
      board[destination_x, destination_y] = self
      self.position = [destination_x, destination_y]
      board[current_x, current_y] = nil
	end

	def perform_slide(destination_x, destination_y)
    raise "Invalid move" if !valid_pos?(destination_x, destination_y)
    raise "Already a piece there." if !board.empty?(destination_x, destination_y)
     current_x, current_y = position
     board[destination_x, destination_y] = self
     self.position = [destination_x, destination_y]
     board[current_x, current_y] = nil
	end

  def perform_moves!(moves)
    if moves.count == 1
        perform_slide(moves[0], moves[1])
    else

    end
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
        if check_for_piece(dx, dy)
            board.remove_piece(current_x + dx, current_y + dy)
            return true
        end
      end
    end
    false
  end

  def valid_pos?(destination_x, destination_y)
    current_x, current_y = position
    move_diffs.each do |dx, dy|
      if (current_x + dx == destination_x) && (current_y + dy == destination_y)
        return true
      end
    end
    false
  end

end


b = Board.new
b[5,1].perform_slide(4,2)
b.display
b[2,0].perform_slide(3,1)
b.display
b[4,2].perform_jump(2,0)
b.display
b[2,4].perform_slide(3,3)
b.display