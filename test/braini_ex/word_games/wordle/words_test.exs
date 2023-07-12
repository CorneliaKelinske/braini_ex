defmodule BrainiEx.WordGames.Wordle.WordsTest do
  use ExUnit.Case

  alias BrainiEx.WordGames.Wordle.Words

  describe "&get_words/0" do
    test "returns a list of 5-letter words" do
      assert [word | _] = Words.get_words()
      assert is_binary(word)
      assert String.length(word) === 5
    end
  end
end
