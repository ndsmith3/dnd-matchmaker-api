defmodule DndMatchmaker.Repo do
  use Ecto.Repo,
    otp_app: :dnd_matchmaker,
    adapter: Ecto.Adapters.Postgres
end
