require 'colored'
require 'colorize'
class Piece
  # STRINGS = { K: " \u2654 ",
  #                   Q: " \u2655 ",
  #                   R: " \u2656 ",
  #                   B: " \u2657 ",
  #                   H: " \u2658 ",
  #                   P: " \u2659 " }
  STRINGS = {
                    K: " \u265A ",
                    Q: " \u265B ",
                    R: " \u265C ",
                    B: " \u265D ",
                    H: " \u265E ",
                    P: " \u265F " }

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

  def dup
    self.class.new(board, pos, color)
  end

end


class SlidingPiece < Piece

  def possible_moves

    possible_moves = []

    self.move_dir.each do |dir|
      factor = 1
      absolute_coord = [pos, dir].transpose.map { |el| el.reduce(&:+) }

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

  def to_s
    if color == "B"
      STRINGS[:Q].red
    else
      STRINGS[:Q].white
    end

  end
end

class Bishop < SlidingPiece

  def move_dir
    [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def to_s
    if color == "B"
      STRINGS[:B].red
    else
      STRINGS[:B].white
    end
  end

end

class Rook < SlidingPiece

  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1]]
  end

  def to_s
    if color == "B"
      STRINGS[:R].red
    else
      STRINGS[:R].white
    end
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

  def to_s
    if color == "B"
      STRINGS[:H].red
    else
      STRINGS[:H].white
    end

  end

end

class Pawn < SteppingPiece
  def move_dir
    move_dirs = []
    if color == "B"
      move_dirs = [[1, 0], [2, 0]]
    else
      move_dirs = [[-1, 0], [-2, 0]] #moving from bottom to top
    end

    first_move? ? move_dirs : [move_dirs.first]

  end

  def attack
    if color == "B"
      [[1, 1], [1, -1]]
    else
      [[-1, 1], [-1, -1]]
    end
  end

  def first_move?
    if color == "B"
      self.pos.first == 1
    else
      self.pos.first == 6
    end
  end

  def to_s
    if color == "B"
      STRINGS[:P].red
    else
      STRINGS[:P].white
    end

  end

end

class King < SteppingPiece
  def move_dir
    [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def to_s
    if color == "B"
      STRINGS[:K].red
    else
      STRINGS[:K].white
    end

  end

end
