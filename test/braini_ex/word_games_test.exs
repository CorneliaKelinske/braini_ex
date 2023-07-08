defmodule BrainiEx.WordGames.Test do
  use ExUnit.Case

  alias BrainiEx.WordGames
  alias BrainiEx.WordGames.Wordle.Game

  describe "&start_wordle_game/0" do
    test "returns a Game struct with a 5 letter secret word" do
      assert %Game{secret_word: secret_word, won: false} = WordGames.start_wordle_game()
      assert is_binary(secret_word)
      assert String.length(secret_word) === 5
    end
  end
end
