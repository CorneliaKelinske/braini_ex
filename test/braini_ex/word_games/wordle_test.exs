defmodule BrainiEx.WordGames.WordleTest do
  use ExUnit.Case
  alias BrainiEx.WordGames.Wordle
  alias BrainiEx.WordGames.Wordle.Game

  @game %Game{
    secret_word: "pizza",
    attempts: 0,
    current_guess: nil,
    won: false,
    color_feedback: []
  }

  @current_guess %{current_guess: "pizza"}

  describe "&create_game/0" do
    test "returns a Game struct with a 5-letter secret word" do
      assert %Game{secret_word: secret_word} = Wordle.create_game()
      assert is_binary(secret_word)
      assert String.length(secret_word) === 5
    end
  end

  describe "&check_guess_and_update_game/2" do
    test "returns updated Game struct when correct guess is entered" do
      assert %Game{
               current_guess: "pizza",
               won: true,
               attempts: 1,
               color_feedback: [
                 {"p", :green},
                 {"i", :green},
                 {"z", :green},
                 {"z", :green},
                 {"a", :green}
               ]
             } = Wordle.check_guess_and_update_game("pizza", @game)
    end

    test "returns updated Game struct with correct color info when guess is incorrect" do
      assert %Game{
               current_guess: "palace",
               won: false,
               attempts: 1,
               color_feedback: [
                 {"p", :green},
                 {"a", :yellow},
                 {"l", :grey},
                 {"a", :yellow},
                 {"c", :grey}
               ]
             } = Wordle.check_guess_and_update_game("palace", @game)
    end
  end
end
