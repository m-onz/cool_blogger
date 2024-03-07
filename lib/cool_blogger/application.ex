defmodule CoolBlogger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CoolBloggerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:cool_blogger, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CoolBlogger.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CoolBlogger.Finch},
      # Start a worker by calling: CoolBlogger.Worker.start_link(arg)
      # {CoolBlogger.Worker, arg},
      # Start to serve requests, typically the last entry
      CoolBloggerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CoolBlogger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoolBloggerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
