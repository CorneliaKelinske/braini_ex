defmodule BrainiExWeb.WordGamesLive.Wordle do
  @moduledoc false

  use BrainiExWeb, :live_view
  import BrainiExWeb.CoreComponents
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
  def handle_event("check", %{"game" => %{"current_guess" => current_guess}}, socket) do
    game = Map.put(socket.assigns.game, :current_guess, current_guess)
    {:noreply, assign(socket, :game, game)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1><%= @title %></h1>
    <p><%= @game.secret_word %></p>
    <p><%= @game.current_guess %></p>

    <div>
      <.simple_form :let={f} for={%{}} as={:game} phx-submit="check">
        <.input field={{f, :current_guess}} label="your guess" />
        <:actions>
          <.button>Check your guess</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end
end
