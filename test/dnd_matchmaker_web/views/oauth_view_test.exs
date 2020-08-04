defmodule DndMatchmakerWeb.LoginViewTest do
  use ExUnit.Case

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders login.json" do
    assert render(DndMatchmakerWeb.LoginView, "login.json", token: "token")
      == %{token_type: "bearer", authorization_token: "token"}
  end
end
