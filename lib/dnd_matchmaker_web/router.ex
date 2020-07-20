defmodule DndMatchmakerWeb.Router do
  use DndMatchmakerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DndMatchmakerWeb do
    pipe_through :api
    # Temporary endpoint for testing connectivity to front-end
    get "/test", TestController, :show
    get "/test/:data", TestController, :reflect
  end
end
