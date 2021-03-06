# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dnd_matchmaker,
  ecto_repos: [DndMatchmaker.Repo]

# Configures the endpoint
config :dnd_matchmaker, DndMatchmakerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OKHGrMhk6GuoeckBdmUjy49UFVNS8+s7btez5cv0TeS0L+JgrbStE++xxQxWNHGx",
  render_errors: [view: DndMatchmakerWeb.ErrorView, accepts: ~w(json)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
