#!/usr/bin/env ruby
# frozen_string_literal: true

# Tic Tac Toe - For The Odin Project
# ------------------------------------------------
# Simple Tic Tac Toe terminal game between two players
# Usage:
# > ./lib/tic_tac_toe.rb

require_relative 'game'

game = Game.new
game.play_game
