class Board
	BLANK = "_|"
  attr_accessor :grid

	def initialize(fillgrid = true)
		fill_board if fillgrid
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

  def dup
    duped_board = Board.new(false)
    duped_grid = Array.new(8) {Array.new(8)}
    duped_board.grid = duped_grid
    self.grid.each_index do |row|
      self.grid.each_index do |col|
        piece = self.grid[row][col]
        next if piece.nil?
        duped_grid[row][col] = Piece.new(duped_board, [row, col], piece.color)
      end
    end
    duped_board
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