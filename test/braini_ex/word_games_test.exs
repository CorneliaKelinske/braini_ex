defmodule BrainiEx.WordGames.Test do
  use ExUnit.Case

  alias BrainiEx.Support.{HTTPSandbox, WordleSandboxResponses}
  alias BrainiEx.WordGames
  alias BrainiEx.WordGames.Wordle.Game

  @game %Game{
    secret_word: "pizza",
    attempts: 0,
    current_guess: nil,
    won: false,
    color_feedback: []
  }

  @message "Unable to request words"

  describe "&start_wordle_game/0" do
    test "returns a Game struct with a 5 letter secret word" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      assert %Game{secret_word: secret_word, won: false} = WordGames.start_wordle_game()
      assert is_binary(secret_word)
      assert String.length(secret_word) === 5
    end

    test "returns Game struct with message from error message as secret word when initial request for words was unsuccessful" do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_error_response()])
      assert %Game{secret_word: @message} = WordGames.start_wordle_game()
    end
  end

  describe "&check_guess/2" do
    test "returns an updated Game struct" do
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
             } = WordGames.check_guess("palace", @game)
    end
  end
end
