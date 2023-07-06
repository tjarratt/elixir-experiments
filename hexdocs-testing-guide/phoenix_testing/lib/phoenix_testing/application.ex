defmodule PhoenixTesting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixTestingWeb.Telemetry,
      # Start the Ecto repository
      PhoenixTesting.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixTesting.PubSub},
      # Start Finch
      {Finch, name: PhoenixTesting.Finch},
      # Start the Endpoint (http/https)
      PhoenixTestingWeb.Endpoint
      # Start a worker by calling: PhoenixTesting.Worker.start_link(arg)
      # {PhoenixTesting.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixTesting.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixTestingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
