defmodule BrainiEx.WordGames.Wordle.Game do
  @moduledoc """
  Defines a wordle game struct for use in a schemaless changeset.
  """

  defstruct secret_word: nil,
            attempts: 0,
            current_guess: nil,
            won: false,
            color_feedback: []

  @type t :: %__MODULE__{
          secret_word: String.t() | nil,
          attempts: non_neg_integer(),
          current_guess: String.t() | nil,
          won: boolean(),
          color_feedback: list()
        }

  @spec new(map()) :: t()
  def new(%{secret_word: _secret_word} = params) do
    struct!(%__MODULE__{}, params)
  end
end
