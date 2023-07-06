defmodule BrainiExWeb.WordGamesLive.WordleTest do
  use BrainiExWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "&Wordle" do
    test "shows correct page", %{conn: conn} do
      assert true
      {:ok, _view, html} = live(conn, ~p"/word_games/wordle")
      assert html =~ "Wordle"
    end
  end
end
