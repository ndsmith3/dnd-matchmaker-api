defmodule DndMatchmakerWeb.TestController do
  use DndMatchmakerWeb, :controller

  def show(conn, _params) do
    render(conn, %{test: "This data was generated by my phoenix server"})
  end

  def reflect(conn, %{"data" => data}) do
    render(conn, %{test: "This data is reflected by phoenix: " <> data})
  end
end