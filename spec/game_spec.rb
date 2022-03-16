# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/computer_player'
require_relative '../lib/board'
require 'rspec'

RSpec.describe Game do
  subject(:game) { described_class.new }

  let(:display_menu) do
    <<~GAME_MENU
      Menu:
      ----------------------------
      1> Single player vs Computer
      2> 2 Players
      3> Exit
      Enter selection: ----------------------------
    GAME_MENU
  end

  context 'when a game is started' do
    describe '#play_game' do
      it 'displays menu and breaks when "3" is input' do
        allow(game).to receive(:gets).and_return('3')
        expect { game.play_game }.to output(display_menu).to_stdout
      end
    end
  end

  context 'private methods tests' do
    let(:player_one) { Player.new('X', 'Player1') }
    let(:player_two) { ComputerPlayer.new('O', 'Player1') }

    before do
      # Create players
      game.instance_variable_set(:@player_one, player_one)
      game.instance_variable_set(:@player_two, player_two)
      # Simulate assign current turn to player_one
      game.instance_variable_set(:@turn, :@player_one)
    end

    describe '#change_turn' do
      it 'changes the turn to the other player' do
        game.send(:change_turn)
        turn = game.instance_variable_get(:@player_two)
        expect(turn).to eql(player_two)
      end
    end

    describe '#get_move' do
      it 'prints twice the message until a valid move is entered' do
        invalid_input = 'zzz'
        valid_input = '0,2'
        allow(player_one).to receive(:gets).and_return(invalid_input, valid_input)
        message = 'Enter valid coordinates(row, column) for move(eg. 1,2): '
        expect { game.send(:get_move, player_one) }.to output(message * 2).to_stdout
      end
    end
  end
end
