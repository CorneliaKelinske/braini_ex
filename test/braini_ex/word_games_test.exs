defmodule BrainiEx.WordGames.Test do
  use ExUnit.Case

  alias BrainiEx.WordGames
  alias BrainiEx.WordGames.Wordle.Game

  @game %Game{
    secret_word: "pizza",
    attempts: 0,
    current_guess: nil,
    won: false,
    color_feedback: []
  }

  describe "&start_wordle_game/0" do
    test "returns a Game struct with a 5 letter secret word" do
      assert %Game{secret_word: secret_word, won: false} = WordGames.start_wordle_game()
      assert is_binary(secret_word)
      assert String.length(secret_word) === 5
    end
  end

  describe "&check_guess/2" do
    test "returns an updated Game struct" do
      assert %Game{
               current_guess: "palace",
               won: false,
               attempts: 1,
               color_feedback: [
                 [
                   {"p", :green},
                   {"a", :yellow},
                   {"l", :grey},
                   {"a", :yellow},
                   {"c", :grey}
                 ]
               ]
             } = WordGames.check_guess("palace", @game)
    end
  end
end
