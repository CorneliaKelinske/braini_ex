defmodule BrainiEx.WordGames.Wordle.Words do
  @moduledoc """
  Pulls in wordle words from a github repo
  """
  @url "https://raw.githubusercontent.com/tabatkins/wordle-list/main/words"
  @words ["toast", "tarts", "pizza"]

  @spec get_words() :: [String.t()]
  def get_words do
    if Mix.env() === :test do
      @words
    else
      @url
      |> Req.get!()
      |> Map.get(:body)
      |> String.split("\n")
    end
  end
end
