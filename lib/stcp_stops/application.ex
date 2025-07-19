defmodule StcpStops.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StcpStopsWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:stcp_stops, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StcpStops.PubSub},
      # Start a worker by calling: StcpStops.Worker.start_link(arg)
      # {StcpStops.Worker, arg},
      # Start to serve requests, typically the last entry
      StcpStopsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StcpStops.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StcpStopsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
