require "minitest/autorun"
require_relative "../tictactoe-core"

describe TicTacToe::Field do
	before do
		@field=TicTacToe::Field.new()
	end
	
	describe "when placing on the field" do
		it "must be a string containing one space in every slot" do
			@field[rand(9)].must_equal(" ")
		end
	end
	
	describe "when checking for win for player 'X'" do
		it "must be false if the field is empty" do
			@field.win("X").must_equal(false)
		end
		it "must be false if another 'O' has won" do
			@field[1
			@field.win("X").must_equal(false)
		end
	end