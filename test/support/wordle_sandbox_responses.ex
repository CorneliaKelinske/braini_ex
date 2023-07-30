defmodule BrainiEx.Support.WordleSandboxResponses do
  @moduledoc false
  @url "https://raw.githubusercontent.com/tabatkins/wordle-list/main/words"
  @words ["toast", "tarts", "pizza"]

  def words_url, do: @url

  def words_response, do: {:ok, @words}

  def words_error_response,
    do: {:error, ErrorMessage.bad_request("Unable to request words", "some error info")}

  def mock_words_response do
    {words_url(), fn -> words_response() end}
  end

  def mock_words_error_response do
    {words_url(), fn -> words_error_response() end}
  end
end
