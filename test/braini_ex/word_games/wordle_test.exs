defmodule BrainiEx.WordGames.WordleTest do
  use ExUnit.Case
  alias BrainiEx.Support.{HTTPSandbox, WordleSandboxResponses}
  alias BrainiEx.WordGames.Wordle
  alias BrainiEx.WordGames.Wordle.Game

  @game %Game{
    secret_word: "pizza",
    attempts: 0,
    current_guess: nil,
    won: false,
    color_feedback: []
  }

  @color_feedback [
    {"p", :green},
    {"a", :yellow},
    {"l", :grey},
    {"a", :yellow},
    {"c", :grey}
  ]

  @message "Unable to request wordle words"

  describe "&create_game/0" do
    test "returns a Game struct with a 5-letter secret word" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      assert %Game{secret_word: secret_word} = Wordle.create_game()
      assert is_binary(secret_word)
      assert String.length(secret_word) === 5
    end

    test "returns Game struct with message from error message as secret word when initial request for words was unsuccessful" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_error_response()])
      assert %Game{secret_word: @message} = Wordle.create_game()
    end
  end

  describe "&check_guess_and_update_game/2" do
    test "returns updated Game struct when correct guess is entered" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])

      assert %Game{
               current_guess: "pizza",
               won: true,
               attempts: 1,
               color_feedback: [
                 [
                   {"p", :green},
                   {"i", :green},
                   {"z", :green},
                   {"z", :green},
                   {"a", :green}
                 ]
               ]
             } = Wordle.check_guess_and_update_game("pizza", @game)
    end

    test "returns updated Game struct with correct color info when guess is incorrect" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])

      assert %Game{
               current_guess: "palace",
               won: false,
               attempts: 1,
               color_feedback: [
                 [
                   {"p", :green},
                   {"a", :yellow},
                   {"l", :gray},
                   {"a", :yellow},
                   {"c", :gray}
                 ]
               ]
             } = Wordle.check_guess_and_update_game("palace", @game)
    end

    test "adds current color feedback to color_feedback" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      game = Map.put(@game, :color_feedback, [@color_feedback])

      assert %Game{
               color_feedback: [
                 @color_feedback,
                 [
                   {"p", :green},
                   {"i", :green},
                   {"z", :green},
                   {"z", :green},
                   {"a", :green}
                 ]
               ]
             } = Wordle.check_guess_and_update_game("pizza", game)
    end
  end
end
