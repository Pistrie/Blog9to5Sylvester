defmodule BlogNineToFiveSylvester.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Logger.add_backend(Sentry.LoggerBackend)

    children = [
      # Start the Telemetry supervisor
      BlogNineToFiveSylvesterWeb.Telemetry,
      # Start the Ecto repository
      BlogNineToFiveSylvester.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BlogNineToFiveSylvester.PubSub},
      # Start Finch
      {Finch, name: BlogNineToFiveSylvester.Finch},
      # Start the Endpoint (http/https)
      BlogNineToFiveSylvesterWeb.Endpoint
      # Start a worker by calling: BlogNineToFiveSylvester.Worker.start_link(arg)
      # {BlogNineToFiveSylvester.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlogNineToFiveSylvester.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BlogNineToFiveSylvesterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
