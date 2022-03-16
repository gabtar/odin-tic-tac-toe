# frozen_string_literal: true

require_relative 'player'
require_relative 'computer_player'
require_relative 'board'

##
# Represents a game of tic-tac-toe
class Game
  def initialize
    @board = Board.new
    @player_one = Player.new('X', 'Player 1')
    @finished = false
  end

  def play_game
    loop do
      option = display_game_menu
      @finished = false
      case option
      when '1'
        new_game(ComputerPlayer.new('O', 'Computer'))
      when '2'
        new_game(Player.new('O', 'Player 2'))
      when '3'
        break
      end
    end
  end

  private

  def display_game_menu
    puts 'Menu:'
    puts '----------------------------'
    puts '1> Single player vs Computer'
    puts '2> 2 Players'
    puts '3> Exit'
    print 'Enter selection: '
    input = gets.chomp
    puts '----------------------------'
    input
  end

  def new_game(player2)
    @board.clean
    @player_two = player2
    @turn = @player_one
    until @finished == true
      puts @board
      puts "Turn: #{@turn} (#{@turn.symbol})"
      move_x, move_y = get_move(@turn)
      @board.mark_board(move_x.to_i, move_y.to_i, @turn.symbol)
      change_turn
      @finished = true if @board.three_in_a_row? || @board.filled?
    end
    finish_game_message
  end

  def change_turn
    @turn = @turn == @player_two ? @player_one : @player_two
  end

  def get_move(player)
    move = ''
    loop do
      move = player.move
      break if  move.match?(/^[0-2],[0-2]$/) &&
                @board.valid_move?(move.split(',')[0].to_i,
                                   move.split(',')[1].to_i)
    end
    move.split(',')
  end

  def finish_game_message
    puts "\n------ GAME FINISHED! ------"
    puts @board
    @finished = false
    if @board.three_in_a_row?
      change_turn
      puts "Winner #{@turn}!!!"
    else
      puts 'TIE game'
    end
    puts '----------------------------'
  end
end
