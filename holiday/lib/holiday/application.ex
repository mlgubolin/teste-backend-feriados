defmodule Holiday.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HolidayWeb.Telemetry,
      Holiday.Repo,
      {DNSCluster, query: Application.get_env(:holiday, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Holiday.PubSub},
      # Start a worker by calling: Holiday.Worker.start_link(arg)
      # {Holiday.Worker, arg},
      # Start to serve requests, typically the last entry
      HolidayWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Holiday.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HolidayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
