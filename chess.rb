class Piece
  attr_accessor :color
  def initialize(color)
    @color = color
  end

end
class SlidingPiece < Piece
  def move(pos)
    self.move_dir   #if valid_move?


  end


end

class Queen < SlidingPiece
  def initialize
  end

  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end
end

class Bishop < SlidingPiece

  def initialize

  end

  def move_dir
    [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

end

class Rook < SlidingPiece
  def initialize
  end

  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1]]
  end
end


class SteppingPiece <Piece
end

class Knight < SteppingPiece
  def move_dir
    [[2, 1], [2, -1], [1, 2], [1, -2], [-2, -1], [-2, 1], [-1, -2], [-1, 2]]
  end
end

class Pawn < SteppingPiece
  def move_dir
    [[0,1]] #moving from bottom to top
  end

  def attack
    [[-1, 1], [1, 1]]
  end
end

class King < SteppingPiece
  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end
end






class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def set_board
    board[0] = Array.new(8)
    board[0] = Rook.new("B"), Knight.new("B"), Bishop.new("B"), King.new("B"), Queen.new("B"), Bishop.new("B"), Knight.new("B"), Rook.new("B")
    board[7] = Rook.new("W"), Knight.new("W"), Bishop.new("W"), King.new("W"), Queen.new("W"), Bishop.new("W"), Knight.new("W"), Rook.new("W")
    board[1] = Array.new(8) { Pawn.new("B") }
    board[6] = Array.new(8) { Pawn.new("W") }
  end

  def [](pos)
    row, col = pos
    board[row][col]
  end

  def valid_move?(pos)
  end
end


class Game
end


class Player
end