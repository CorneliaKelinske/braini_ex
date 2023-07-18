defmodule BrainiEx.WordGames.Wordle.RandomWordGeneratorTest do
  use ExUnit.Case
  alias BrainiEx.WordGames.Wordle.RandomWordGenerator

  setup do
    start_supervised!({RandomWordGenerator, %{}})
    :ok
  end

  @words ["toast", "tarts", "pizza"]

  describe "&get_word/0" do
    test "returns an unused 5-letter words when unused words are available" do
      assert word1 = RandomWordGenerator.get_word()
      assert word1 in @words

      assert word2 = RandomWordGenerator.get_word()
      assert word3 = RandomWordGenerator.get_word()

      assert word1 !== word2 !== word3
    end

    test "resets list of unused words when all words are used up" do
      assert word1 = RandomWordGenerator.get_word()
      assert word2 = RandomWordGenerator.get_word()
      assert word3 = RandomWordGenerator.get_word()

      assert word4 = RandomWordGenerator.get_word()

      assert word4 === word1 or word4 === word2 or word4 === word3
    end
  end
end
