defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller

  def index(conn, _params) do
    live_render(conn, HangmanWeb.PageLiveView, session: %{})
  end
end
