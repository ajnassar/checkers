require_relative "board"
require_relative "piece"
class InvalidMoveError < StandardError
  def initialize(msg = "There is an error here.")
    super
  end
end

class Game



end

b = Board.new
b[5, 1].perform_moves!([[4,2]])
#b[5,1].perform_slide(4,2)
p b

#b[2,0].perform_slide(3,1)
b[2, 0].perform_moves!([[3,1]])
p b

#b[4,2].perform_jump(2,0)
b[4, 2].perform_moves!([[2,0]])
p b

#b[2,4].perform_slide(3,3)
b[2, 4].perform_moves!([[3,3]])
p b

b[5, 3].perform_moves!([[4,2]])
p b

b[3, 3].perform_moves!([[5,1]])
p b

b[2, 2].perform_moves!([[3,3]])
p b
