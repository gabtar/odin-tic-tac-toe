# frozen_string_literal: true

require_relative '../lib/board'
require 'rspec'

RSpec.describe Board do
  subject(:board) { described_class.new }
  let(:fill_board) do
    3.times do |row|
      3.times do |column|
        board.mark_board(row, column, 'X')
      end
    end
  end

  describe '#mark_board' do
    it 'marks a square with the "x"(cross)' do
      row = 1
      column = 1
      empty = ' '
      type = 'X'
      expect { board.mark_board(row, column, type) }
        .to change { board.instance_variable_get(:@board)[row][column] }
        .from(empty).to(type)
    end

    it 'marks a square with the "o"(circle)' do
      row = 1
      column = 1
      empty = ' '
      type = 'o'
      expect { board.mark_board(row, column, type) }
        .to change { board.instance_variable_get(:@board)[row][column] }
        .from(empty).to(type)
    end

    it 'it does not mark a square if it already is marked with a symbol' do
      row = 1
      column = 1
      type = 'o'
      board.mark_board(row, column, type)
      expect { board.mark_board(row, column, type) }
        .not_to change { board.instance_variable_get(:@board)[row][column] }
    end
  end

  describe '#three_in_a_row?' do
    let(:type) { 'X' }

    it 'returns true if there are 3 "X" in a row' do
      board.mark_board(0, 0, type)
      board.mark_board(0, 1, type)
      board.mark_board(0, 2, type)
      expect(board.three_in_a_row?).to be_truthy
    end


    it 'returns true if there are 3 "X" in a column' do
      board.mark_board(0, 0, type)
      board.mark_board(1, 0, type)
      board.mark_board(2, 0, type)
      expect(board.three_in_a_row?).to be_truthy
    end

    it 'returns true if there are 3 "X" in a diagonal' do
      board.mark_board(0, 0, type)
      board.mark_board(1, 1, type)
      board.mark_board(2, 2, type)
      expect(board.three_in_a_row?).to be_truthy
    end

    it 'returns false if there are not 3 "X" in a row, column or diagonal' do
      board.mark_board(0, 1, type)
      board.mark_board(0, 2, type)
      expect(board.three_in_a_row?).to be_falsy
    end
  end

  describe '#filled?' do
    it 'returns true if the board is complete' do
      fill_board
      expect(board.filled?).to be_truthy
    end

    it 'returns false if the board is not complete' do
      2.times do |row|
        2.times do |column|
          board.mark_board(row, column, 'X')
        end
      end
      expect(board.filled?).to be_falsy
    end
  end

  describe '#valid_move?' do
    let(:row) { 0 }
    let(:column) { 1 }

    it 'returns true if there is no mark in the selected square' do
      expect(board.valid_move?(row, column)).to be_truthy
    end

    it 'returns false if there is a mark in the selected square' do
      board.mark_board(row, column, 'X')
      expect(board.valid_move?(row, column)).to be_falsy
    end
  end

  describe '#clean' do
    let(:clean_board) { Array.new(3) { Array.new(3, ' ') } }
    it 'clear all marks in the board' do
      fill_board
      expect { board.clean }
        .to change { board.instance_variable_get(:@board) }
        .to(clean_board)
    end
  end

  describe '#to_s' do
    let(:empty_board) do
      <<~EMPTY_BOARD
            0   1   2
           ----------- 
        0 |   |   |   |
          |-----------|
        1 |   |   |   |
          |-----------|
        2 |   |   |   |
           ----------- 
      EMPTY_BOARD
    end

    it 'returns the empty board string' do
      expect(board.to_s).to eql(empty_board)
    end
  end
end
