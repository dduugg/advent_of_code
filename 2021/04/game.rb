# typed: false
# frozen_string_literal: true

require_relative './board'

# A Bingo game including boards and a list of numbers to draw in order
class Game
  extend T::Sig

  sig { params(filepath: String).void }
  def initialize(filepath)
    input = File.readlines(filepath).map(&:chomp)
    @numbers = input.shift.split(',').map(&:to_i)
    @boards = []
    boards_to_add = input.each_slice(6).map do |rows|
      break if rows.size != 6

      rows[1..].map { |row| row.split.map(&:to_i) }
    end
    boards_to_add.each { add_board(_1) }
  end

  sig { params(board: Board::Rows).void }
  def add_board(board)
    @boards << Board.new(board)
  end

  sig { returns(Integer) }
  def play_to_win
    @numbers.each do |number|
      @boards.each do |board|
        board.draw(number)
        return board.score(number) if board.win?
      end
    end
  end

  sig { returns(Integer) }
  def play_to_lose
    boards = @boards.clone
    @numbers.each do |number|
      boards.delete_if do |board|
        board.draw(number)
        if board.win?
          return boards.fetch(0).score(number) if boards.size == 1

          true
        end
      end
    end
  end
end
