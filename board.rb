require 'colored'
require 'colorize'
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
    inject([]) { |dup, el| dup << (el.is_a?(Array) ? el.deep_dup : el.dup) }
  end

  def move(color, start_pos, target_pos)
    if valid_move?(color, start_pos, target_pos)
      self[start_pos].move(target_pos)
    else
      puts "Can't move there!"
    end
  end

  def valid_move?(color, start_pos, target_pos)
    #in bounds on board, #valid direction, #not obstructed
    self[start_pos].possible_moves.include?(target_pos) &&
    #doesn't leave own king in check
    # !king_checked?                                      &&

    #target_pos doesn't have own piece
    !replacing_own_piece?(color, target_pos)            &&
    moving_own_color?(color, start_pos)


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

  #not attacking our own piece
  def replacing_own_piece?(color, target_pos)
    self[target_pos] && self[target_pos].color == color
  end

  #moving your own color
  def moving_own_color?(color, start_pos)
    color == self[start_pos].color
  end

  def display
    board.each do |row|
      row.each do |piece|
        print piece.is_a?(Piece) ? piece.to_s : " \u25A2 ".white
      end
      puts ""
    end
    puts "\n------------------------".light_blue
  end

end