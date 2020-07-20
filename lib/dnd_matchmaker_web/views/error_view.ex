defmodule DndMatchmakerWeb.ErrorView do
  use DndMatchmakerWeb, :view

  def render("400.json", _assigns) do
    %{error: %{message: "Bad request"}}
  end

  def render("404.json", _assigns) do
    %{error: %{message: "Not found"}}
  end

  def render("500.json", _assigns) do
    %{error: %{message: "Internal Error"}}
  end
end
