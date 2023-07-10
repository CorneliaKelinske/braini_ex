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

  @types %{
    secret_word: :string,
    attempts: :integer,
    current_guess: :string,
    won: :boolean,
    color_feedback: :list
  }

  @required_attrs [:secret_word, :attempts, :won, :color_feedback]
  @attrs [:current_guess] ++ @required_attrs

  import Ecto.Changeset

  @spec changeset(t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = game, attrs) do
    {game, @types}
    |> cast(attrs, @attrs)
    |> validate_required(@required_attrs)
  end

  @spec new(map()) :: t()
  def new(%{secret_word: _secret_word} = params) do
    Map.merge(%__MODULE__{}, params)
  end
end
