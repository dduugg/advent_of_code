#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require_relative './board'

class Game
  extend T::Sig

  class Strategy < T::Enum
    enums do
      Lose = new
      Win = new
    end
  end

  sig { params(numbers: T::Array[Integer], boards: T::Array[Board::Rows]).void }
  def initialize(numbers, boards)
    @numbers = numbers
    @boards = []
    boards.each { add_board(_1) }
  end

  sig { params(board: Board::Rows).void }
  def add_board(board)
    @boards << Board.new(board)
  end

  sig { params(strategy: Strategy).void }
  def play(strategy = Strategy::Win)
    boards = @boards.clone
    @numbers.each_with_index do |number, i|
      boards.delete_if do |board|
        board.draw(number)
        if board.win?
          case strategy
          when Strategy::Lose
            if boards.size == 1
              puts boards.first.score(number)
              return
            else
              true
            end
          when Strategy::Win
            puts board.score(number)
            return
          else T.absurd(strategy)
          end
        end
      end
    end
  end
end
