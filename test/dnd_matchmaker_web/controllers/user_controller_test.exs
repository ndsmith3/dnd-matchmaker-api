defmodule DndMatchmakerWeb.UserControllerTest do
  use ExUnit.Case

  import Plug.Conn
  import Phoenix.ConnTest

  @endpoint DndMatchmakerWeb.Endpoint

  alias DndMatchmaker.Accounts
  alias DndMatchmaker.Accounts.User

  @create_attrs %{
    email: "some email",
    password: "some password",
    username: "some username"
  }
  @update_attrs %{
    email: "some updated email",
    password: "some updated password",
    username: "some updated username"
  }
  @invalid_attrs %{email: nil, password: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup do
    assert :ok = Ecto.Adapters.SQL.Sandbox.checkout(DndMatchmaker.Repo)
    %{conn: build_conn()}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, "/api/v1/register", %{user: @create_attrs})
      resp = json_response(conn, 201)["data"]
      assert resp["id"] != nil
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/v1/register", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = assign_bearer_token(conn, user)
      conn = put(conn, "/api/v1/user", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, "/api/v1/user")

      assert %{
               "id" => id,
               "email" => "some updated email",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = assign_bearer_token(conn, user)
      conn = put(conn, "/api/v1/user", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = assign_bearer_token(conn, user)
      conn = delete(conn, "/api/v1/user")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, "/api/v1/user")
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end

  defp assign_bearer_token(conn, user) do
    put_req_header(conn, "authorization", "Bearer " <> DndMatchmakerWeb.JWT.generate_and_sign!(%{sub: user.id}))
  end
end
