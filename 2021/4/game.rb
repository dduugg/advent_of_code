# typed: strict
# frozen_string_literal: true

require_relative './board'

# A Bingo game including boards and a list of numbers to draw in order
class Game
  extend T::Sig

  # Whether to pick the cards that wins first (Win) or last (Lose)
  class Strategy < T::Enum
    enums do
      Lose = new
      Win = new
    end
  end

  sig { params(numbers: T::Array[Integer], boards: T::Array[Board::Rows]).void }
  def initialize(numbers, boards)
    @numbers = numbers
    @boards = T.let([], T::Array[Board])
    boards.each { add_board(_1) }
  end

  sig { params(board: Board::Rows).void }
  def add_board(board)
    @boards << Board.new(board)
  end

  sig { params(strategy: Strategy).void }
  def play(strategy = Strategy::Win)
    boards = @boards.clone
    @numbers.each do |number|
      boards.delete_if do |board|
        board.draw(number)
        if board.win?
          case strategy
          when Strategy::Lose
            if boards.size == 1
              puts boards.fetch(0).score(number)
              return nil
            else
              true
            end
          when Strategy::Win
            puts board.score(number)
            return nil
          else T.absurd(strategy)
          end
        end
      end
    end
  end
end
