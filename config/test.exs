use Mix.Config

# Configure your database
config :dnd_matchmaker, DndMatchmaker.Repo,
  username: "postgres",
  password: "postgres",
  database: "dnd_matchmaker_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dnd_matchmaker, DndMatchmakerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :joken, default_signer: "test"
config :bcrypt_elixir, log_rounds: 4
