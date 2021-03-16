# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bank_api, BankAPI,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: BankAPI.EventStore
  ],
  pubsub: :local,
  registry: :local

config :bank_api, BankAPI.EventStore,
  column_data_type: "jsonb",
  serializer: Commanded.Serialization.JsonSerializer,
  types: EventStore.PostgresTypes

config :bank_api, event_stores: [BankAPI.EventStore]

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: BankAPI.Repo

config :bank_api,
  namespace: BankAPI,
  ecto_repos: [BankAPI.Repo]

# Configures the endpoint
config :bank_api, BankAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wU/NdbWhfpE/QCsFvTzu0fuEI/Vgu4FlZDF24M8Mp2fyT6/sWPvbmf5knq4O9ljb",
  render_errors: [view: BankAPIWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BankAPI.PubSub,
  live_view: [signing_salt: "BRBf4UYj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
