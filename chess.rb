require "pp"
class Piece
  attr_accessor :color, :pos, :board
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def move(target_pos)
    board[self.pos] = nil
    self.pos = target_pos
    board[target_pos] = self
  end

end


class SlidingPiece < Piece

  def possible_moves

    possible_moves = []

    self.move_dir.each do |dir|
      factor = 1
      relative_coord = dir.map { |el| el * factor }
      absolute_coord = [pos, relative_coord].transpose.map { |el| el.reduce(&:+) }

      until factor > 7 || board[absolute_coord].is_a?(Piece)
        relative_coord = dir.map { |el| el * factor }
        absolute_coord = [pos, relative_coord].transpose.map { |el| el.reduce(&:+) }
        possible_moves << absolute_coord if absolute_coord.all? { |coord| coord.between?(0,7) }
        factor += 1
      end
    end

    possible_moves
  end

end

class Queen < SlidingPiece

  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def render
    "Q"
  end
end

class Bishop < SlidingPiece

  def move_dir
    [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def render
    "B"
  end

end

class Rook < SlidingPiece

  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1]]
  end

  def render
    "R"
  end

end


class SteppingPiece <Piece

  def possible_moves

    possible_moves = []

    self.move_dir.each do |dir|
      absolute_coord = [pos, dir].transpose.map { |el| el.reduce(&:+) }
      possible_moves << absolute_coord if absolute_coord.all? { |coord| coord.between?(0,7) }
    end

    possible_moves
  end
end

class Knight < SteppingPiece
  def move_dir
    [[2, 1], [2, -1], [1, 2], [1, -2], [-2, -1], [-2, 1], [-1, -2], [-1, 2]]
  end

  def render
    "H"
  end

end

class Pawn < SteppingPiece
  def move_dir
    [[0,1]] #moving from bottom to top
  end

  def attack
    [[-1, 1], [1, 1]]
  end

  def render
    "P"
  end

end

class King < SteppingPiece
  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def render
    "K"
  end

end






class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    set_board
  end

  def set_board
    board[0] = Rook.new(self, [0, 0], "B"), Knight.new(self, [0, 1], "B"), Bishop.new(self, [0, 2], "B"), King.new(self, [0, 3], "B"), Queen.new(self, [0, 4], "B"), Bishop.new(self, [0, 5], "B"), Knight.new(self, [0, 6], "B"), Rook.new(self, [0, 7], "B")
    board[7] = Rook.new(self, [7, 0], "W"), Knight.new(self, [7, 1], "W"), Bishop.new(self, [7, 2], "W"), King.new(self, [7, 3], "W"), Queen.new(self, [7, 4], "W"), Bishop.new(self, [7, 5], "W"), Knight.new(self, [7, 6], "W"), Rook.new(self, [7, 7], "W")
    (0..7).each do |col|
      #board[1][col] = Pawn.new(self, [0, col], "W")
      board[6][col] = Pawn.new(self, [0, col], "B")
    end
  end

  def [](pos)
    row, col = pos
    board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    board[row][col] = val
  end

  def deep_dup
    inject([]) { |dup, el| dup << (el.is_a?(Array) ? el.deep_dup : el) }
  end

  def move(start_pos, target_pos)
    if valid_move?(start_pos, target_pos)
      self[start_pos].move(target_pos)
    else
      raise ArgumentError, "Can't move there!"
    end
  end

  def valid_move?(start_pos, target_pos)
    #in bounds on board, #valid direction, #not obstructed
    pp self[start_pos].possible_moves
    self[start_pos].possible_moves.include?(target_pos) #
    #doesn't leave own king in check
    # !king_checked?                                       &&

    #target_pos doesn't have own piece
  #  own_piece?(target_pos)


  end

  def king_checked?(target_pos)
    copy_board = board.deep_dup

    copy_board[target_pos] = self
    copy_board[self.pos] = nil

    copy_board.each do |row|
      row.each do |piece|
        next if !piece.is_a? Piece
        next if piece.color == self.color


      end
    end
  end

  def own_piece?(target_pos)
    self[target_pos] && self[target_pos].color == true
  end

  #moving your own color
  def moving_valid_color?
  end

  def display
    board.each do |row|
      row.each do |piece|
        print piece.is_a?(Piece) ? piece.render + " " : "- "
      end
      puts ""
    end
  end

end


class Game

end


class Player
end

b = Board.new
b.display
b.move([0,1],[1,3])
b.display
b.move([1,3],[2,5])
b.display
b.move([2,5],[4,7])
