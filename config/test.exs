use Mix.Config

# Configures the event store database
config :bank_api, BankAPI.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "bank_api_test_eventstore",
  hostname: "localhost",
  pool_size: 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bank_api, BankAPI.Repo,
  username: "postgres",
  password: "postgres",
  database: "bank_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank_api, BankAPIWeb.Endpoint,
  http: [port: 4002],
  server: false

config :ex_unit_notifier, clear_history: true

# Print only warnings and errors during test
config :logger, level: :warn

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.InMemory

config :commanded, Commanded.EventStore.Adapters.InMemory,
  serializer: Commanded.Serialization.JsonSerializer
