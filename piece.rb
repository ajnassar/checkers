# -*- coding: utf-8 -*-
class Piece
  SYMBOL = { :white => '♙|', :black => '♟|' }
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
    return false if !valid_jump_pos?(destination_x, destination_y)
    return false if !board.empty?(destination_x, destination_y)
    dx = (destination_x - position[0] ) / 2
    dy = (destination_y - position[1]) / 2
    p position[0] + dx; p position[1] + dy
    board.remove_piece(position[0] + dx, position[1] + dy)
    current_x, current_y = position
    board[destination_x, destination_y] = self
    self.position = [destination_x, destination_y]
    board[current_x, current_y] = nil
    return true
	end

  def perform_moves(moves)
    if valid_move_seq?(moves)
      perform_moves!(moves)
    else
      raise InvalidMoveError, "error in non bang"
    end
  end

  def perform_moves!(moves)
    if moves.count == 1
        if !perform_slide(moves[0][0], moves[0][1])
          perform_jump(moves[0][0], moves[0][1])
        end
    else
      moves.each do |move|
        if !perform_jump(move[0], move[1])
          raise InvalidMoveError
        end
      end
    end
  end

  def valid_move_seq?(moves)
    dup_board = board.dup
    x, y = position
    begin
      dup_board[x, y].perform_moves!(moves)
      return true
    rescue InvalidMoveError
      return false
    end
  end

	def perform_slide(destination_x, destination_y)
    return false if !valid_pos?(destination_x, destination_y)
    return false if !board.empty?(destination_x, destination_y)
    current_x, current_y = position
    board[destination_x, destination_y] = self
    self.position = [destination_x, destination_y]
    board[current_x, current_y] = nil
    return true
	end

	def to_s
		SYMBOL[color]
	end

  def valid_jump_pos?(destination_x, destination_y)
    current_x, current_y = position
    move_diffs.each do |dx, dy|
      if (current_x + dx + dx == destination_x) && (current_y + dy + dy == destination_y)
        if check_for_piece(dx, dy)
            #board.remove_piece(current_x + dx, current_y + dy)
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