defmodule BrainiEx.WordGames.Wordle.GameTest do
  use ExUnit.Case

  alias BrainiEx.WordGames.Wordle.Game

  @params %{secret_word: "pizza"}
  @attrs %{secret_word: "hotel", attempts: 1, current_guess: "pizza"}

  describe "&new/1" do
    test "returns a new game struct with the passed in secret word" do
      assert %BrainiEx.WordGames.Wordle.Game{
               secret_word: "pizza",
               attempts: 0,
               current_guess: nil,
               won: false
             } === Game.new(@params)
    end
  end
end
