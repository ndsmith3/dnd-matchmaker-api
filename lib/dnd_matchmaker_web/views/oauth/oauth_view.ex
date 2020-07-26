defmodule DndMatchmakerWeb.OAuthView do
  use DndMatchmakerWeb, :view

  def render("authorize.json", %{token: token}) do
    %{authorization_token: token}
  end
end
