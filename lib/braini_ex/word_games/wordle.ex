defmodule BrainiEx.WordGames.Wordle do
  @moduledoc """
  Contains the functions and logic for a wordle game as well as
  """
  alias BrainiEx.WordGames.Wordle.{Game, RandomWordGenerator, Words}

  @message "Unable to request wordle words"

  @spec create_game() :: Game.t()
  def create_game do
    secret_word = get_random_word()
    Game.new(%{secret_word: secret_word})
  end

  @spec check_guess_and_update_game(String.t(), Game.t()) :: Game.t()
  def check_guess_and_update_game(
        guess,
        %Game{secret_word: secret_word, attempts: attempts, color_feedback: color_feedback} = game
      ) do
    game = Map.put(game, :current_guess, String.downcase(guess))

    process_guess_and_apply_updates(game)
  end

  if Mix.env() === :test do
    defp get_random_word do
      case Words.get_words() do
        {:ok, words} -> Enum.random(words)
        {:error, %ErrorMessage{message: @message}} -> @message
      end
    end
  else
    defp get_random_word do
      RandomWordGenerator.get_word()
    end
  end

  defp process_guess_and_apply_updates(
         %{
           current_guess: secret_word,
           secret_word: secret_word,
           color_feedback: color_feedback,
           attempts: attempts
         } = game
       ) do
    current_color_feedback =
      secret_word
      |> String.graphemes()
      |> Enum.map(&{&1, :green})

    color_feedback = color_feedback ++ [current_color_feedback]
    Map.merge(game, %{color_feedback: color_feedback, won: true, attempts: attempts + 1})
  end

  defp process_guess_and_apply_updates(
         %{
           current_guess: current_guess,
           color_feedback: color_feedback,
           attempts: attempts,
           secret_word: secret_word
         } = game
       ) do
    guess_letters = String.graphemes(current_guess)
    secret_word_letters = String.graphemes(secret_word)
    current_color_feedback = check_letters(guess_letters, secret_word_letters)
    color_feedback = color_feedback ++ [current_color_feedback]

    Map.merge(game, %{color_feedback: color_feedback, attempts: attempts + 1})
  end

  defp check_letters(guess_letters, secret_word_letters) do
    guess_letters
    |> Enum.zip(secret_word_letters)
    |> Enum.map(&compare_guessed_letter(&1, secret_word_letters))
  end

  defp compare_guessed_letter({guessed_letter, guessed_letter}, _), do: {guessed_letter, :green}

  defp compare_guessed_letter({guessed_letter, _}, secret_word_letters) do
    if guessed_letter in secret_word_letters do
      {guessed_letter, :yellow}
    else
      {guessed_letter, :gray}
    end
  end
end
