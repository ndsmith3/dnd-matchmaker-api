defmodule DndMatchmakerWeb.Plugs.AuthorizationPlugTest do
  use ExUnit.Case

  import Plug.Conn
  import Phoenix.ConnTest

  setup do
    %{conn: build_conn()}
  end

  describe "call" do
    test "should return error when no token is given", %{conn: conn} do
      conn = DndMatchmakerWeb.Plugs.AuthorizationPlug.call(conn, [])
      assert conn.halted
      assert conn.status == 400
      assert conn.resp_body == Jason.encode!%{error: %{message: :bearer_token_not_found}}
    end

    test "should return error when token is Basic", %{conn: conn} do
      conn =
        conn
        |> put_req_header("authorization", "Basic token")
        |> DndMatchmakerWeb.Plugs.AuthorizationPlug.call([])
      assert conn.halted
      assert conn.status == 400
      assert conn.resp_body == Jason.encode!%{error: %{message: :basic_auth_not_supported}}
    end

    test "should return error when token is not a signed jwt", %{conn: conn} do
      conn =
        conn
        |> put_req_header("authorization", "Bearer token")
        |> DndMatchmakerWeb.Plugs.AuthorizationPlug.call([])
      assert conn.halted
      assert conn.status == 401
      assert conn.resp_body == Jason.encode!%{error: %{message: :signature_error}}
    end

    test "should set :user_id when token is a signed jwt", %{conn: conn} do
      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> DndMatchmakerWeb.JWT.generate_and_sign!(%{"sub" => 1}))
        |> DndMatchmakerWeb.Plugs.AuthorizationPlug.call([])
      assert conn.private[:user_id] == 1
      assert !conn.halted
    end
  end
end
