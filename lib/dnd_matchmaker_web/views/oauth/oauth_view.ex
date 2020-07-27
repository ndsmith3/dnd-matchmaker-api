defmodule DndMatchmakerWeb.OAuthView do
  use DndMatchmakerWeb, :view

  def render("authorize.json", %{token: token}) do
    %{token_type: "bearer", authorization_token: token}
  end
end
