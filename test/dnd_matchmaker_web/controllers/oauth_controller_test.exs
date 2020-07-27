defmodule DndMatchmakerWeb.OAuthControllerTest do
  use ExUnit.Case

  import Phoenix.ConnTest

  @endpoint DndMatchmakerWeb.Endpoint

  @auth "/oauth/auth"

  setup do
    assert :ok = Ecto.Adapters.SQL.Sandbox.checkout(DndMatchmaker.Repo)
    %{conn: build_conn()}
  end

  test "authorize renders bad_request when using unavailable grant_type", %{conn: conn} do
    conn = post(conn, @auth, %{
      "grant_type" => "not a grant type"
    })
    assert conn.status == 400
    assert conn.resp_body == Jason.encode! %{"error" => %{"message" => "invalid_grant_type"}}
  end

  describe "password grant" do
    setup [:create_user]

    test "authorize rendors unauthorized when given unmatching user/pass", %{conn: conn, user: user} do
      conn = post(conn, @auth, %{
        "grant_type" => "password",
        "username" => user.username,
        "password" => "not the password"
      })
      assert conn.status == 401
      assert conn.resp_body == Jason.encode! %{"error" => %{"message" => :no_username_or_pass_match}}
    end

    test "authorize rendors bearer token when given valid user/pass", %{conn: conn, user: user} do
      conn = post(conn, @auth, %{
        "grant_type" => "password",
        "username" => user.username,
        "password" => "password"
      })
      assert conn.status == 200
      assert {:ok, claims} = DndMatchmakerWeb.JWT.verify_and_validate(Jason.decode!(conn.resp_body)["authorization_token"])
      assert claims["sub"] == user.id
      assert claims["username"] == user.username
    end
  end

  defp create_user(_) do
    {:ok, user} = DndMatchmaker.Accounts.create_user(%{username: "bob", email: "bob@aol.com", password: "password"})
    %{user: user}
  end
end
