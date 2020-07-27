defmodule DndMatchmakerWeb.UserView do
  use DndMatchmakerWeb, :view
  alias DndMatchmakerWeb.UserView

  def render("register.json", %{user: user}) do
    %{user_id: user.id}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      username: user.username}
  end
end
