defmodule BrainiEx.Support.WordleSandboxResponses do
  @moduledoc false
  @url "https://raw.githubusercontent.com/tabatkins/wordle-list/main/words"
  @words ["toast", "tarts", "pizza"]

  def words_url, do: @url

  def words_response, do: @words

  def mock_words_response do
    {words_url(), fn -> words_response() end}
  end
end
