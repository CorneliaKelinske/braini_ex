defmodule BrainiEx.WordGames.WordleTest do
  use ExUnit.Case
  alias BrainiEx.WordGames.Wordle.Wordle

  describe "&word/0" do
    test "returns a 5-letter word" do
      word = Wordle.word()
      assert is_binary(word)
      assert String.length(word) === 5
    end
  end
end
