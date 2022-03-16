# frozen_string_literal: true

##
# Represents a player in the tic-tac-toe
class Player
  attr_reader :name, :symbol

  def initialize(symbol, name)
    @name = name
    @symbol = symbol
  end

  def move
    print 'Enter valid coordinates(row, column) for move(eg. 1,2): '
    gets.chomp
  end

  def to_s
    @name
  end
end
