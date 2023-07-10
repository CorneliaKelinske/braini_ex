defmodule BrainiEx.WordGames.Wordle.GameTest do
  use ExUnit.Case

  alias BrainiEx.WordGames.Wordle.Game

  @params %{secret_word: "pizza"}
  @attrs %{secret_word: "hotel", attempts: 1, current_guess: "pizza"}
  @invalid_attrs %{secret_word: "hotel"}

  describe "&new/1" do
    test "returns a new game struct with the passed in secret word" do
      assert %BrainiEx.WordGames.Wordle.Game{
               secret_word: "pizza",
               attempts: 0,
               current_guess: nil,
               won: false
             } === Game.new(@params)
    end
  end

  describe "&changeset/1" do
    test "returns a valid changeset struct when valid attributes are provided" do
      assert %Ecto.Changeset{
               changes: %{attempts: 1, current_guess: "pizza", secret_word: "hotel"},
               valid?: true
             } = Game.changeset(%Game{}, @attrs)
    end

    test "returns  invalid changeset struct when valid attributes are provided" do
      assert %Ecto.Changeset{
               changes: %{secret_word: "hotel"},
               errors: [current_guess: {"can't be blank", [validation: :required]}],
               valid?: false
             } = Game.changeset(%Game{}, @invalid_attrs)
    end
  end
end
