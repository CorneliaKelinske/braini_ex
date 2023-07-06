defmodule BrainiEx.WordGames do
  @moduledoc """
  Too-layer module with functions for playing word games
  """

  alias BrainiEx.WordGames.Wordle

  @spec get_wordle_word() :: String.t()
  defdelegate get_wordle_word, to: Wordle, as: :word
end
