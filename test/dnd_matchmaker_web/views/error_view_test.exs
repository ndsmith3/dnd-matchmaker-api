defmodule DndMatchmakerWeb.ErrorViewTest do
  use ExUnit.Case

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 400.json default" do
    assert render(DndMatchmakerWeb.ErrorView, "400.json", []) == %{error: %{message: :bad_request}}
  end

  test "renders 400.json with message" do
    assert render(DndMatchmakerWeb.ErrorView, "400.json", message: :test_error) == %{error: %{message: :test_error}}
  end

  test "renders 401.json default" do
    assert render(DndMatchmakerWeb.ErrorView, "401.json", []) == %{error: %{message: :unauthorized}}
  end

  test "renders 401.json with message" do
    assert render(DndMatchmakerWeb.ErrorView, "401.json", message: :test_error) == %{error: %{message: :test_error}}
  end

  test "renders 403.json" do
    assert render(DndMatchmakerWeb.ErrorView, "403.json", []) == %{error: %{message: :forbidden}}
  end

  test "renders 404.json" do
    assert render(DndMatchmakerWeb.ErrorView, "404.json", []) == %{error: %{message: :not_found}}
  end

  test "renders 500.json" do
    assert render(DndMatchmakerWeb.ErrorView, "500.json", []) == %{error: %{message: :internal_server_error}}
  end
end
