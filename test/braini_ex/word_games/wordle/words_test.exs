defmodule BrainiEx.WordGames.Wordle.WordsTest do
  use ExUnit.Case

  alias BrainiEx.Support.{HTTPSandbox, WordleSandboxResponses}
  alias BrainiEx.WordGames.Wordle.Words

  describe "&get_words/1" do
    test "returns tuple with :ok and a list of 5-letter words" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      assert {:ok, [word | _]} = Words.get_words()
      assert is_binary(word)
      assert String.length(word) === 5
    end

    test "returns error tuple for unsuccessful request" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_error_response()])

      assert {:error,
              %ErrorMessage{
                code: :bad_request,
                message: "Unable to request wordle words",
                details: "some error info"
              }} = Words.get_words()
    end
  end

  describe "&get_words/1 against live site" do
    @describetag :http
    test "returns a list of 5-letter words" do
      assert {:ok, [word | _]} = Words.get_words(sandbox?: false)
      assert is_binary(word)
      assert String.length(word) === 5
    end
  end
end
