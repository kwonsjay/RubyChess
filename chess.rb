require "./board.rb"
require "./pieces.rb"

class Game

end


class Player

end

b = Board.new
b.display
b.move("W", [7,4],[6,3])
b.display
#p b[[6,3]].possible_moves
#possible_moves
p b.check("B")
b.move("W", [6,3],[7,4])
b.display
p b.check("B")
# b.move("W", [7,0],[6,0])
# b.display
# #p b.check("B")
# b.move("B", [0,1],[1,3])
# b.display
# b.move("B", [0,2],[2,0])
# b.display
# b.move("B", [0,3],[1,2])
# b.display
# b.move("B", [0,4],[2,6])
# b.display

# b.move("W", [7,5],[6,4])
# b.display


