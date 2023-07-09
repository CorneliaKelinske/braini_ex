defmodule BrainiEx.WordGames do
  @moduledoc """
  Too-layer module with functions for playing word games
  """

  alias BrainiEx.WordGames.Wordle
  alias BrainiEx.WordGames.Wordle.Game

  @spec start_wordle_game() :: Game.t()
  defdelegate start_wordle_game, to: Wordle, as: :create_game

  @spec check_guess(String.t(), Game.t()) :: Game.t()
  defdelegate check_guess(guess, game), to: Wordle, as: :check_guess_and_update_game
end
