defmodule BankAPI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Commanded application
      BankAPI,
      # Application event store
      # BankAPI.EventStore,
      # Start the Ecto repository
      BankAPI.Repo,
      # Start the Telemetry supervisor
      BankAPIWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BankAPI.PubSub},
      # Start the Endpoint (http/https)
      BankAPIWeb.Endpoint,
      # Start a worker by calling: BankAPI.Worker.start_link(arg)
      # {BankAPI.Worker, arg}
      BankAPI.Accounts.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BankAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BankAPIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
