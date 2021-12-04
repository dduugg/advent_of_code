#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require_relative './board'

class Game

  def initialize(numbers, boards)
    @numbers = numbers
    @boards = []
    boards.each { add_board(_1) }
  end

  def add_board(board)
    @boards << Board.new(board)
  end

  def play
    @numbers.each do |number|
      @boards.each do |board|
        board.draw(number)
        if board.win?
          puts board.score(number)
          return
        end
      end
    end
  end
end
