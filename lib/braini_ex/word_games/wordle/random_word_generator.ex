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

  @spec start_link(list()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec get_word() :: String.t()
  def get_word do
    GenServer.call(__MODULE__, :get_word)
  end

  # Server

  @impl GenServer
  def init(_) do
    case words() do
      {:ok, words} -> {:ok, words}
      {:error, %ErrorMessage{message: @message}} -> {:ok, [@message]}
      error -> {:error, ErrorMessage.internal_server_error("Something went wrong", inspect(error))}
    end
  end

  @impl GenServer
  def handle_call(:get_word, _from, [@message] = state) do
    {:reply, @message, state}
  end

  def handle_call(:get_word, _from, state) do
    word = Enum.random(state)
    new_state = state -- [word]
    {:reply, word, new_state}
  end

  if Mix.env() === :test do
    defp words, do: {:ok, @words}
  else
    defp words, do: Words.get_words()
  end
end
