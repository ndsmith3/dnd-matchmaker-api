defmodule DndMatchmakerWeb.TestView do
  use DndMatchmakerWeb, :view

  def render("show.json", %{test: test}) do
    %{test: test}
  end

  def render("reflect.json", %{test: test}) do
    %{test: test}
  end
end
