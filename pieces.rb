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

  def render
    # STRINGS[color][self.class.to_s]
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
