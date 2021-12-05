#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

class Board
  extend T::Sig

  Row = T.type_alias { [Integer, Integer, Integer, Integer, Integer] }
  Rows = T.type_alias { [Row, Row, Row, Row, Row] }

  sig { returns(Rows) }
  attr_reader :rows, :matches

  sig { params(rows: Rows).void }
  def initialize(rows)
    @rows = T.let(rows, Rows)
    @matches = T.let([
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
      ], Rows)
  end

  sig { params(int: Integer).void }
  def draw(int)
    @rows.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == int
          @matches[i][j] = 1
        end
      end
    end
  end

  sig { void }
  def foo
    puts @rows.map { _1.join(' ') }
    puts @matches.map { _1.join(' ') }
  end

  sig { params(last_drawn: Integer).returns(Integer) }
  def score(last_drawn)
    acc = 0
    @rows.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        acc += cell if @matches[i][j].zero?
      end
    end
    acc * last_drawn
  end

  sig { returns(T::Boolean) }
  def win?
    @matches.each do |row|
      return true if row.all? { _1 == 1 }
    end
    (0..4).each do |i|
      return true if @matches.all? { _1[i] == 1 }
    end
    false
  end
end
