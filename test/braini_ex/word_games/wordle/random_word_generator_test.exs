defmodule BrainiEx.WordGames.Wordle.RandomWordGeneratorTest do
  use ExUnit.Case
  alias BrainiEx.WordGames.Wordle.RandomWordGenerator

  setup do
    start_supervised!({RandomWordGenerator, %{}})
    :ok
  end

  @words ["toast", "tarts", "pizza"]

  describe "&get_word/0" do
    test "returns a 5-letter word" do
      assert word1 = RandomWordGenerator.get_word()
      assert word1 in @words

      assert word2 = RandomWordGenerator.get_word()
      assert word3 = RandomWordGenerator.get_word()

      assert word1 !== word2 !== word3
    end
  end
end
