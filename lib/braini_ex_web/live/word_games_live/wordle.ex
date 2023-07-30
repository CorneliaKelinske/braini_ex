defmodule BrainiExWeb.WordGamesLive.Wordle do
  @moduledoc false

  use BrainiExWeb, :live_view
  import BrainiExWeb.CoreComponents
  alias BrainiEx.WordGames
  alias BrainiEx.WordGames.Wordle.Game

  @title "Five Letters"
  @message "Unable to request words"

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign_title(@title)
     |> assign_game()}
  end

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

  @impl Phoenix.LiveView
  def handle_event("restart", _, socket) do
    {:noreply, redirect(socket, to: ~p"/word_games/five_letters")}
  end

  defp assign_title(socket, title), do: assign(socket, title: title)

  defp assign_game(socket) do
    case WordGames.start_wordle_game() do
      %Game{secret_word: @message} ->
        socket
        |> put_flash(:error, "Five Letters is currently not available")
        |> redirect(to: "/")

      game ->
        assign(socket, game: game)
    end
  end

  defp assign_game_update(socket, current_guess, game) do
    assign(socket, game: WordGames.check_guess(current_guess, game))
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1 class="font-bold text-2xl text-gray-900 mb-8"><%= @title %></h1>
    <div>
      <%= for feedback <- @game.color_feedback do %>
        <p>
          <%= for {letter, color} <- feedback do %>
            <span id="coloredLetter" class={[color(color)]}><%= letter %></span>
          <% end %>
        </p>
      <% end %>
    </div>
    <%= if @game.attempts < 6 and @game.won === false do %>
      <div>
        <.simple_form :let={f} for={%{}} as={:game} phx-submit="check" additional_classes="w-48">
          <.input
            field={{f, :current_guess}}
            label="Your guess"
            additional_classes="tracking-widest text-gray-900 text-4xl"
          />
        </.simple_form>
      </div>
    <% else %>
      <%= if @game.won === false do %>
        <p>You lost! The secret word was:</p>
        <p><%= @game.secret_word %></p>
      <% end %>

      <.button class="mt-2 bg-violet-900 hover:bg-violet-700" phx-click="restart">
        Play again!
      </.button>
    <% end %>
    """
  end

  defp color(:green), do: "text-green-500"
  defp color(:yellow), do: "text-yellow-500"
  defp color(:gray), do: "text-gray-500"
end
