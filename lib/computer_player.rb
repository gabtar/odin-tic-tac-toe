# frozen_string_literal: true

require_relative 'player'

##
# Represents a computer player in the tic-tac-toe
class ComputerPlayer < Player
  def move
    "#{rand(0..2)},#{rand(0..2)}"
  end
end
