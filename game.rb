require_relative "board"
require_relative "piece"

class Game

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