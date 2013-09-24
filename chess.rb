require "pp"
require "./board.rb"
require "./pieces.rb"

class Game

end


class Player

end

b = Board.new
b.display
b.move([0,1],[2,0])
b.display
b.move([0,0],[1,0])
b.display
b.move([6,1],[5,1])
b.display
