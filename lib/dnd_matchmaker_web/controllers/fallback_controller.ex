defmodule DndMatchmakerWeb.FallbackController do
  use DndMatchmakerWeb, :controller

  def call(conn, {:error, :bad_request, msg}) do
    conn
    |> put_status(:bad_request)
    |> put_view(DndMatchmakerWeb.ErrorView)
    |> render(:"400", message: msg)
  end

  def call(conn, {:error, :unauthorized, msg}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(DndMatchmakerWeb.ErrorView)
    |> render(:"401", message: msg)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(422)
    |> put_view(DndMatchmakerWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
