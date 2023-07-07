defmodule BrainiEx.WordGames.Wordle.GuessTest do
  use ExUnit.Case

  alias BrainiEx.WordGames.Wordle.Guess

  @attrs %{secret_word: "hotel", attempts: 1, current_guess: "pizza"}
  @invalid_attrs %{secret_word: "hotel"}

  describe "&changeset/1" do
    test "returns a valid changeset struct when valid attributes are provided" do
      assert %Ecto.Changeset{
               changes: %{attempts: 1, current_guess: "pizza", secret_word: "hotel"},
               valid?: true
             } = Guess.changeset(@attrs)
    end

    test "returns  invalid changeset struct when valid attributes are provided" do
      assert %Ecto.Changeset{
               changes: %{secret_word: "hotel"},
               errors: [current_guess: {"can't be blank", [validation: :required]}],
               valid?: false
             } = Guess.changeset(@invalid_attrs)
    end
  end
end
