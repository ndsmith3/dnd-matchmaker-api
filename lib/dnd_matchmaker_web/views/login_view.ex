defmodule DndMatchmakerWeb.LoginView do
  use DndMatchmakerWeb, :view

  def render("login.json", %{token: token}) do
    %{token_type: "bearer", authorization_token: token}
  end
end
