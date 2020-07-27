defmodule DndMatchmakerWeb.UserController do
  use DndMatchmakerWeb, :controller

  alias DndMatchmaker.Accounts
  alias DndMatchmaker.Accounts.User

  action_fallback DndMatchmakerWeb.FallbackController

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, _opts) do
    with user <- Accounts.get_user!(conn.private[:user_id]) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"user" => user_params}) do
    user = Accounts.get_user!(conn.private[:user_id])

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _opts) do
    user = Accounts.get_user!(conn.private[:user_id])

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
