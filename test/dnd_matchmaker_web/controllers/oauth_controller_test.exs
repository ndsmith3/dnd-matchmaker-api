defmodule DndMatchmakerWeb.OAuthControllerTest do
  use ExUnit.Case

  import Phoenix.ConnTest

  @endpoint DndMatchmakerWeb.Endpoint

  @auth "/oauth/auth"

  setup do
    %{conn: build_conn()}
  end

  test "authorize renders bad_request when using unavailable grant_type", %{conn: conn} do
    conn = conn |> post(@auth, %{
      "grant_type" => "not a grant type"
    })
    assert conn.status == 400
    assert conn.resp_body == Jason.encode! %{"error" => %{"message" => "invalid_grant_type"}}
  end

  describe "password grant" do
    test "authorize rendors unauthorized when given unmatching user/pass", %{conn: conn} do
      conn = conn |> post(@auth, %{
        "grant_type" => "password",
        "username" => "bob",
        "password" => "not the password"
      })
      assert conn.status == 401
      assert conn.resp_body == Jason.encode! %{"error" => %{"message" => :no_username_or_pass_match}}
    end

    test "authorize rendors bearer token when given valid user/pass", %{conn: conn} do
      conn = conn |> post(@auth, %{
        "grant_type" => "password",
        "username" => "bob",
        "password" => "password"
      })
      assert conn.status == 200
      assert Jason.decode!(conn.resp_body)["authorization_token"] =~ ~r/(.*)\.(.*)\.(.*)/
    end
  end
end
