#!/usr/bin/env ruby
# frozen_string_literal: true

# Tic Tac Toe - For The Odin Project
# ------------------------------------------------
# Simple Tic Tac Toe terminal game between two players
# Usage:
# > ./tic_tac_toe.rb

# require 'pry-byebug'

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

##
# Represents a player in the tic-tac-toe
class Player
  attr_reader :name, :symbol

  @@number = 0

  def initialize(symbol)
    @@number += 1
    @name = "Player #{@@number}"
    @symbol = symbol
  end

  def to_s
    @name
  end
end

##
# Represents a game of tic-tac-toe
class Game
  def initialize
    @board = Board.new
    @player_one = Player.new('X')
    @player_two = Player.new('O')
    @finished = false
    @turn = @player_one
  end

  def play_game
    continue = true
    while continue
      new_game
      print 'Play again?(y/n)'
      @finished = false
      continue = false if gets.chomp == 'n'
    end
  end

  private

  def new_game
    @board.clean
    until @finished == true
      puts @board
      puts "Turn: #{@turn} (#{@turn.symbol})"
      move_x, move_y = input_move.split(',')
      @board.mark_board(move_x.to_i, move_y.to_i, @turn.symbol)
      change_turn
      @finished = true if @board.three_in_a_row? || @board.filled?
    end
    finish_game_message
  end

  def change_turn
    @turn = @turn == @player_two ? @player_one : @player_two
  end

  def input_move
    input = ''
    loop do
      until input.match?(/^[0-2],[0-2]$/)
        print 'Enter coordinates(row, column) for move(eg. 1,2): '
        input = gets.chomp
      end
      break if @board.valid_move?(input.split(',')[0].to_i, input.split(',')[1].to_i)

      puts 'Invalid move.'
      input = ''
    end
    input
  end

  def finish_game_message
    puts "\n------ GAME FINISHED! ------"
    puts @board
    if @board.three_in_a_row?
      puts "Winner #{@turn}!!!"
    else
      puts 'TIE game'
    end
    puts '----------------------------'
  end
end

game = Game.new
game.play_game
