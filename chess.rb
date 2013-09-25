require "./board.rb"
require "./pieces.rb"

class Game

end


class Player

end

b = Board.new
b.display
b.move("B", [1,0],[3,0])
b.display
b.move("B", [1,1],[2,1])
b.display
b.move("B", [2,1],[1,1])
b.display
b.move("W", [6,1],[4,1])
b.display