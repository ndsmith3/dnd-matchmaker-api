defmodule DndMatchmakerWeb.ErrorView do
  use DndMatchmakerWeb, :view

  def render("400.json", %{message: message}) do
    %{error: %{message: message}}
  end

  def render("400.json", _assigns) do
    %{error: %{message: :bad_request}}
  end

  def render("401.json", %{message: message}) do
    %{error: %{message: message}}
  end

  def render("401.json", _assigns) do
    %{error: %{message: :unauthorized}}
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
