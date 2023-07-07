defmodule BrainiEx.WordGames.Wordle.Game do
  @moduledoc """
  Defines a wordle game struct for use in a schemaless changeset.
  """

  defstruct secret_word: nil,
            attempts: 0,
            current_guess: nil

  @type t :: %__MODULE__{
          secret_word: String.t() | nil,
          attempts: non_neg_integer(),
          current_guess: String.t() | nil
        }

  @spec types :: %{
          secret_word: :string,
          attempts: :integer,
          current_guess: :string
        }
  def types do
    %{
      secret_word: :string,
      attempts: :integer,
      current_guess: :string
    }
  end
end
