# frozen_string_literal: true

##
# Represents a board of tic-tac-toe
class Board
  def initialize(size = 3)
    @size = size
    @board = Array.new(size) { Array.new(size, ' ') }
  end

  def to_s
    board = ''
    board += "    0   1   2\n"
    board += "   ----------- \n"
    @board.each_with_index do |row, row_index|
      board += "#{row_index} | #{row[0]} | #{row[1]} | #{row[2]} |\n"
      board += "  |-----------|\n" if row_index != 2
    end
    board += "   ----------- \n"
    board
  end

  def mark_board(row, column, type)
    @board[row][column] = type
  end

  def three_in_a_row?
    horizontal = false
    vertical = false
    diagonal = false
    @board.length.times do |index|
      horizontal = true if @board[index][0] == @board[index][1] &&
                           @board[index][1] == @board[index][2] &&
                           (@board[index][0] == 'X' || @board[index][0] == 'O')
      vertical = true if @board[0][index] == @board[1][index] &&
                         @board[1][index] == @board[2][index] &&
                         (@board[0][index] == 'X' || @board[0][index] == 'O')
    end

    diagonal = true if @board[0][0] == @board[1][1] &&
                       @board[1][1] == @board[2][2] &&
                       (@board[0][0] == 'X' || @board[0][0] == 'O')

    diagonal = true if @board[0][2] == @board[1][1] &&
                       @board[1][1] == @board[2][0] &&
                       (@board[0][2] == 'X' || @board[0][2] == 'O')

    horizontal || vertical || diagonal
  end

  def valid_move?(row, column)
    @board[row][column] == ' '
  end

  def filled?
    blank = 0
    @board.each { |row| row.each { |square| blank += 1 if square == ' ' } }
    blank.zero?
  end

  def clean
    @board = Array.new(@size) { Array.new(@size, ' ') }
  end
end
