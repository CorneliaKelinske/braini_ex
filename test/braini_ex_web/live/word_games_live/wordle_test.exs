defmodule BrainiExWeb.WordGamesLive.WordleTest do
  use BrainiExWeb.ConnCase

  import Phoenix.LiveViewTest

  alias BrainiEx.WordGames.Wordle.RandomWordGenerator

  setup do
    start_supervised!(RandomWordGenerator, [])
    :ok
  end

  describe "&Wordle" do
    test "shows correct page", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/word_games/wordle")
      assert html =~ "Wordle"
    end

    test "adds current guess to list when form is submitted", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/word_games/wordle")

      assert render_submit(view, :check, %{"game" => %{"current_guess" => "pizza"}}) =~
               "coloredLetter"
    end

    test "restarts game when Play again is clicked", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/word_games/wordle")
      send(view.pid, {:restart, %{}})
      refute render(view) =~ "coloredLetter"
    end
  end
end
