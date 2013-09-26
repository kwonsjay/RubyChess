require 'colored'
require 'colorize'
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    set_board
  end

  def set_board
    board[0] = Rook.new(self, [0, 0], "B"), Knight.new(self, [0, 1], "B"),
               Bishop.new(self, [0, 2], "B"), Queen.new(self, [0, 3], "B"),
               King.new(self, [0, 4], "B"), Bishop.new(self, [0, 5], "B"),
               Knight.new(self, [0, 6], "B"), Rook.new(self, [0, 7], "B")
    board[7] = Rook.new(self, [7, 0], "W"), Knight.new(self, [7, 1], "W"),
               Bishop.new(self, [7, 2], "W"), Queen.new(self, [7, 3], "W"),
               King.new(self, [7, 4], "W"), Bishop.new(self, [7, 5], "W"),
               Knight.new(self, [7, 6], "W"), Rook.new(self, [7, 7], "W")

    (0..7).each do |col|
      board[1][col] = Pawn.new(self, [1, col], "B")
      board[6][col] = Pawn.new(self, [6, col], "W")
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
    dup_board = Board.new
    copy_board = Array.new(8) { Array.new(8) }
    board.each do |row|
      row.each do |piece|
        next if piece.nil?

        copy_board[piece.pos[0]][piece.pos[1]] = piece.class.new(dup_board, piece.pos, piece.color)
      end
    end
    dup_board.board = copy_board
    dup_board
  end

  def move(color, start_pos, target_pos)
    if valid_move?(color, start_pos, target_pos)
      self[start_pos].move(target_pos)
    else
      raise ArgumentError, "Can't move there!"
    end
  end

  def valid_move?(color, start_pos, target_pos)
    #in bounds on board, #valid direction, #not obstructed
    self[start_pos].possible_moves.include?(target_pos) &&
    #doesn't leave own king in check
    !move_check?(start_pos, target_pos)                 &&

    #target_pos doesn't have own piece
    !replacing_own_piece?(color, target_pos)            &&
    moving_own_color?(color, start_pos)


  end

  def check?(color)
    opponent_moves = []
    king_pos = []
    self.board.each do |row|
      row.each do |piece|
        next unless piece.is_a?(Piece)
        opponent_moves += piece.possible_moves if piece.color != color
        king_pos = piece.pos if piece.is_a?(King) && piece.color == color
      end
    end

    opponent_moves.include?(king_pos)
  end

  def move_check?(start_pos, target_pos)
    copy_board = self.deep_dup

    moving_piece = copy_board[start_pos]
    moving_piece.move(target_pos)

    copy_board.check?(moving_piece.color)
  end

  def checkmate?(color)
    return false unless check?(color)
    own_pieces = []
    self.board.each do |row|
      row.each do |piece|
        next unless piece.is_a?(Piece) && piece.color == color

        own_pieces << piece
      end
    end

    own_pieces.each do |own_piece|
      own_piece.possible_moves.each do |move|
        return false if valid_move?(color, own_piece.pos, move)
      end
    end
    true
  end

  def replacing_own_piece?(color, target_pos)
    self[target_pos] && self[target_pos].color == color
  end

  def moving_own_color?(color, start_pos)
    color == self[start_pos].color
  end

  def display
    puts "  0  1  2  3  4  5  6  7".light_blue
    board.each_with_index do |row, index|
      print "#{index}".light_blue
      col = 0
      row.each do |piece|
        color = (index.even? && col.odd?) || (index.odd? && col.even?) ? :blue : :cyan
        print piece.is_a?(Piece) ? piece.to_s.colorize(background: color) : "   ".colorize(background: color)
        col += 1
      end
      puts ""
    end
    puts "\n-------------------------".light_blue
  end

end