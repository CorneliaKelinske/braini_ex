defmodule BrainiEx.WordGames.Wordle do
  @moduledoc """
  Contains the functions and logic for a wordle game as well as
  """
  alias BrainiEx.WordGames.Wordle.Game
  @words ["toast", "tarts", "pizza", "hello", "beats"]

  @spec create_game() :: Game.t()
  def create_game do
    secret_word = word()
    Game.new(%{secret_word: secret_word})
  end

  @spec check_guess_and_update_game(String.t(), Game.t()) :: Game.t()
  def check_guess_and_update_game(
        guess,
        %Game{secret_word: secret_word, attempts: attempts} = game
      ) do
    guess = String.downcase(guess)

    if guess === secret_word do
      color_feedback =
        guess
        |> String.graphemes()
        |> Enum.map(&{&1, :green})

      Map.merge(game, %{
        current_guess: guess,
        won: true,
        attempts: attempts + 1,
        color_feedback: color_feedback
      })
    else
      guess_letters = String.graphemes(guess)
      secret_word_letters = String.graphemes(secret_word)
      color_feedback = check_letters(guess_letters, secret_word_letters)

      Map.merge(game, %{
        current_guess: guess,
        won: false,
        attempts: attempts + 1,
        color_feedback: color_feedback
      })
    end
  end

  defp word do
    Enum.random(@words)
  end

  defp check_letters(guess_letters, secret_word_letters) do
    guess_letters
    |> Enum.zip(secret_word_letters)
    |> Enum.map(&compare(&1, secret_word_letters))
  end

  defp compare({guessed_letter, guessed_letter}, _), do: {guessed_letter, :green}

  defp compare({guessed_letter, _}, secret_word_letters) do
    if guessed_letter in secret_word_letters do
      {guessed_letter, :yellow}
    else
      {guessed_letter, :grey}
    end
  end
end
