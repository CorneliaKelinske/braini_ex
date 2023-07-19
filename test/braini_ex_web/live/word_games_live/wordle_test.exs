defmodule BrainiExWeb.WordGamesLive.WordleTest do
  use BrainiExWeb.ConnCase

  import Phoenix.LiveViewTest

  alias BrainiEx.Support.{HTTPSandbox, WordleSandboxResponses}

  describe "&Wordle" do
    test "shows correct page", %{conn: conn} do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      {:ok, _view, html} = live(conn, ~p"/word_games/wordle")
      assert html =~ "Wordle"
    end

    test "redirects to home when secret word consists of error message", %{conn: conn} do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_error_response()])

      {:error, {:redirect, %{flash: %{"error" => "Wordle currently not available"}, to: "/"}}} =
        live(conn, ~p"/word_games/wordle")
    end

    test "adds current guess to list when form is submitted", %{conn: conn} do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])
      {:ok, view, _html} = live(conn, ~p"/word_games/wordle")

      assert render_submit(view, :check, %{"game" => %{"current_guess" => "pizza"}}) =~
               "coloredLetter"
    end

    test "restarts game when Play again is clicked", %{conn: conn} do
      HTTPSandbox.set_get_responses([WordleSandboxResponses.mock_words_response()])

      {:ok, view, _html} = live(conn, ~p"/word_games/wordle")
      send(view.pid, {:restart, %{}})
      refute render(view) =~ "coloredLetter"
    end
  end
end
