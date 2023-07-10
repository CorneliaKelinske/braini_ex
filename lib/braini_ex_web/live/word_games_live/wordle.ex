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
  def handle_event(
        "check",
        %{"game" => %{"current_guess" => current_guess}},
        %{assigns: %{game: game}} = socket
      ) do
    if String.length(current_guess) !== 5 do
      {:noreply, put_flash(socket, :error, "Word must be 5 letters long")}
    else
      {:noreply, assign_game_update(socket, current_guess, game)}
    end
  end

  defp assign_game_update(socket, current_guess, game) do
    assign(socket, game: WordGames.check_guess(current_guess, game))
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
