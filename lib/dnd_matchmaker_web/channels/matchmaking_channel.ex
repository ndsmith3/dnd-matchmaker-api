defmodule DndMatchmakerWeb.MatchmakingChannel do
  use Phoenix.Channel

  def join("matchmaking:queue", _message, socket) do
    {:ok, socket}
  end

  # Dummy handler that just returns what the user sent for now
  def handle_in("join", %{"body" => body}, socket) do
    broadcast!(socket, "test", %{"body" => body})
    {:noreply, socket}
  end
end
