defmodule DndMatchmakerWeb.LogoutController do
  use DndMatchmakerWeb, :controller

  action_fallback DndMatchmakerWeb.FallbackController

  def logout(conn, _params) do
    conn
    |> delete_resp_cookie("session_token")
    |> render(%{})
  end
end
