# frozen_string_literal: true

require_relative '../lib/player'
require 'rspec'

RSpec.describe Player do
  subject(:player) { described_class.new('X', 'Test') }

  context 'when the player input a move' do
    before do
      input = '0,2'
      allow(player).to receive(:gets).and_return(input)
    end

    describe '#move' do
      it 'print message and recives a input' do
        message = 'Enter valid coordinates(row, column) for move(eg. 1,2): '
        expect{ player.move }.to output(message).to_stdout
      end
    end
  end

  describe '#to_s' do
    it 'returns the name of the player' do
      expect(player.to_s).to eq('Test')
    end
  end
end
