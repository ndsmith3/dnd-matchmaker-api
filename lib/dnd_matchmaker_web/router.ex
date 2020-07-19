defmodule DndMatchmakerWeb.Router do
  use DndMatchmakerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DndMatchmakerWeb do
    pipe_through :api
  end
end
