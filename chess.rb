require "./board.rb"
require "./pieces.rb"

class Game
  attr_accessor :board, :current_turn, :previous_turn, :white

  def initialize
    @board = Board.new
    @white = true
    @previous_turn = "B"
    @current_turn = "W"
  end

  def play
    game_over = false
    print_intro

    until game_over
      start_loc = make_turn
      end_turn(start_loc)
      self.previous_turn = current_turn
      next_turn
      game_over = board.checkmate?(current_turn)
    end
    puts "Checkmate! Winner is #{previous_turn}!"
  end

  def print_intro
    puts "Welcome to Chess!"
    board.display
  end

  def make_turn
    puts "#{current_turn}, select your piece."
    start_loc = gets.chomp.split(" ").map(&:to_i)
    until board[start_loc].is_a?(Piece) && board[start_loc].color == current_turn
      puts "#{current_turn}, NO. Try again."
      start_loc = gets.chomp.split(" ").map(&:to_i)
    end
    start_loc
  end

  def end_turn(start_loc)
    begin
      puts "#{current_turn}, select destination."
      end_loc = gets.chomp.split(" ").map(&:to_i)
      board.move(current_turn, start_loc, end_loc)
    rescue
      puts "NO. Try again."
      retry
    end
  end

  def next_turn
    self.white = !white
    self.current_turn = white ? "W" : "B"
    board.display
  end
end


g = Game.new
g.play
# b = Board.new
# b.display
# b.move("W", [7,7],[0,7])
# b.display
# b.move("W", [0,7],[0,6])
# b.display
# b.move("W", [0,6],[0,5])
# b.display
# b.move("W", [0,5],[0,4])
# b.display
# b.move("B", [0,3],[1,3])
# b.display
# b.move("B", [1,3],[2,3])
# b.display
# b.move("W", [0,4],[0,3])
# b.display
# p "Checkmate? #{b.checkmate?("B")}"
# b.move("W", [7,0],[2,0])
# b.display
# b.move("W", [7,2],[5,4])
# b.display
# b.move("W", [5,4],[4,3])
# b.display
# b.move("W", [7,1],[5,0])
# b.display
# b.move("W", [5,0],[3,1])
# b.display
# p "Checkmate? #{b.checkmate?("B")}"




