# frozen_string_literal: true

require_relative '../lib/computer_player'
require_relative '../lib/player'
require 'rspec'

RSpec.describe ComputerPlayer do
  subject(:cpu_player) { described_class.new('O', 'CPU') }

  context 'when the cpu player input a move' do

    matcher :valid_input do
      match { |input| input.match?(/^[0-2],[0-2]$/) }
    end

    describe '#move' do
      it 'returns a valid move for the board' do
        expect(cpu_player.move).to match(valid_input)
      end
    end
  end
end
