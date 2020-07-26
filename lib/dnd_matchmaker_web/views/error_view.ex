defmodule DndMatchmakerWeb.ErrorView do
  use DndMatchmakerWeb, :view

  def render("400.json", assigns) do
    message = assigns |> Map.get(:message, :bad_request)
    %{error: %{message: message}}
  end

  def render("401.json", assigns) do
    message = assigns |> Map.get(:message, :unauthorized)
    %{error: %{message: message}}
  end

  def render("403.json", _assigns) do
    %{error: %{message: :forbidden}}
  end

  def render("404.json", _assigns) do
    %{error: %{message: :not_found}}
  end

  def render("500.json", _assigns) do
    %{error: %{message: :internal_server_error}}
  end
end
