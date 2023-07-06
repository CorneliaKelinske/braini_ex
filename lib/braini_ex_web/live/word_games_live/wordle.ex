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
     |> assign_word()}
  end

  defp assign_title(socket, title), do: assign(socket, title: title)
  defp assign_word(socket), do: assign(socket, secret_word: WordGames.get_wordle_word())

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1><%= @title %></h1>
    <p><%= @secret_word %></p>
    """
  end
end
