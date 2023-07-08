defmodule BrainiExWeb.WordGamesLive.Wordle do
  @moduledoc false

  use BrainiExWeb, :live_view
  alias BrainiEx.WordGames

  @title "Wordle"

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign_title(@title)
     |> assign_game()}
  end

  defp assign_title(socket, title), do: assign(socket, title: title)
  defp assign_game(socket), do: assign(socket, game: WordGames.start_wordle_game())

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1><%= @title %></h1>
    <p><%= @game.secret_word %></p>
    """
  end
end
