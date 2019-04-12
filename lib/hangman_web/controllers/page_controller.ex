defmodule HangmanWeb.PageController do
  use HangmanWeb, :controller
  alias Phoenix.LiveView.Controller, as: LiveController

  def index(conn, _params) do
    LiveController.live_render(conn, HangmanWeb.PageLiveView, session: %{})
  end
end
