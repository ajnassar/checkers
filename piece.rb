# -*- coding: utf-8 -*-
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