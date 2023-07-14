defmodule BrainiEx.WordGames.Wordle.WordsTest do
  use ExUnit.Case

  alias BrainiEx.Support.{HTTPSandbox, WordleSandboxResponses}
  alias BrainiEx.WordGames.Wordle.Words

  describe "&get_words/1" do
    test "returns a list of 5-letter words" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      assert [word | _] = Words.get_words()
      assert is_binary(word)
      assert String.length(word) === 5
    end
  end

  describe "&get_words/1 against live site" do
    @describetag :http
    test "returns a list of 5-letter words" do
      assert [word | _] = Words.get_words(sandbox?: false)
      assert is_binary(word)
      assert String.length(word) === 5
    end
  end
end
