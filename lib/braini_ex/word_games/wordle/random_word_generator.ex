defmodule BrainiEx.WordGames.Wordle.RandomWordGenerator do
  @moduledoc """
  Pulls in a list of wordle words, generates a random word for a game
  and ensures that words are only used once during a game
  """
  use GenServer

  alias BrainiEx.WordGames.Wordle.Words

  @words ["toast", "tarts", "pizza"]
  @message "Unable to request wordle words"

  # Client

  @spec start_link(map()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(%{}) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec get_word() :: String.t()
  def get_word do
    GenServer.call(__MODULE__, :get_word)
  end

  # Server

  @impl GenServer
  def init(_) do
    case words() do
      {:ok, words} -> {:ok, %{all_words: words, unused_words: words}}
      {:error, %ErrorMessage{message: @message}} -> {:ok, %{all_words: @message}}
      error -> {:error, ErrorMessage.internal_server_error("Something went wrong", inspect(error))}
    end
  end

  @impl GenServer
  def handle_call(:get_word, _from, %{all_words: @message} = state) do
    {:reply, @message, state}
  end

  def handle_call(:get_word, _from, %{unused_words: unused_words} = state) do
    word = Enum.random(unused_words)
    unused_words = unused_words -- [word]
    new_state = Map.put(state, :unused_words, unused_words)
    {:reply, word, new_state}
  end

  if Mix.env() === :test do
    defp words, do: {:ok, @words}
  else
    defp words, do: Words.get_words()
  end
end
