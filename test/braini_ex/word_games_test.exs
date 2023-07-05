defmodule BrainiEx.WordGames.Test do
  use ExUnit.Case

  alias BrainiEx.WordGames

  describe "&get_wordle_word/0" do
    test "returns a 5 letter word" do
      word = WordGames.get_wordle_word()
      assert is_binary(word)
      assert String.length(word) === 5
    end
  end
end
