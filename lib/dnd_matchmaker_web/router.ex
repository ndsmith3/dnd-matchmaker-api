defmodule DndMatchmakerWeb.Router do
  use DndMatchmakerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug DndMatchmakerWeb.Plugs.AuthorizationPlug
  end

  scope "/api/v:version", DndMatchmakerWeb do
    pipe_through :api
    # Temporary endpoint for testing connectivity to front-end
    get    "/test",       TestController, :show
    get    "/test/:data", TestController, :reflect
    post   "/register",   UserController, :register
  end

  scope "/api/v:version", DndMatchmakerWeb do
    pipe_through :api
    pipe_through :auth

    get    "/user", UserController, :show
    put    "/user", UserController, :update
    delete "/user", UserController, :delete
  end

  scope "/oauth", DndMatchmakerWeb do
    pipe_through :api
    post "/auth", OAuthController, :authorize
  end
end
