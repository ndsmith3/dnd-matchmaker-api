defmodule DndMatchmakerWeb.OAuthViewTest do
  use ExUnit.Case

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders authorize.json" do
    assert render(DndMatchmakerWeb.OAuthView, "authorize.json", token: "token") == %{authorization_token: "token"}
  end
end
