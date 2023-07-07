defmodule BrainiEx.WordGames.Wordle.Wordle do
  @moduledoc """
  Contains the functions and logic for a wordle game as well as
  """
  @words ["toast", "tarts", "pizza", "hello", "beats"]

  @spec word() :: String.t()
  def word do
    Enum.random(@words)
  end
end
