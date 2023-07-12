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
      assert true
      {:ok, _view, html} = live(conn, ~p"/word_games/wordle")
      assert html =~ "Wordle"
    end
  end
end
