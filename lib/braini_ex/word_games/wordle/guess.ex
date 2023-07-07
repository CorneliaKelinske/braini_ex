defmodule BrainiEx.WordGames.Wordle.Guess do
  @moduledoc """
  Defines the changeset for the guess form to
  be submitted when the user makes a guess
  """

  alias BrainiEx.WordGames.Wordle.Game
  import Ecto.Changeset

  @attrs [:secret_word, :attempts, :current_guess]

  @spec changeset(map) :: Ecto.Changeset.t()
  def changeset(attrs) do
    {%Game{}, Game.types()}
    |> cast(attrs, @attrs)
    |> validate_required(@attrs)
  end
end
