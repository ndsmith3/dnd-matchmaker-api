defmodule DndMatchmakerWeb.LogoutControllerTest do
  use ExUnit.Case

  import Plug.Conn
  import Phoenix.ConnTest

  @endpoint DndMatchmakerWeb.Endpoint

  setup do
    %{conn: build_conn()}
  end

  test "logout deletes session_token cookie", %{conn: conn} do
    conn =
      conn
      |> put_req_header("cookie", "session_token=" <> DndMatchmakerWeb.JWT.generate_and_sign!(%{"sub" => 1}) <> ";")
      |> post("/api/v1/logout", %{})
      |> fetch_cookies()
    assert conn.status == 200
    assert conn.resp_body == Jason.encode! %{}
    assert !conn.cookies["session_token"]
  end
end
