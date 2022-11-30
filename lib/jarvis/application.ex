defmodule Jarvis.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JarvisWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Jarvis.PubSub},
      # Start the Endpoint (http/https)
      JarvisWeb.Endpoint
      # Start a worker by calling: Jarvis.Worker.start_link(arg)
      # {Jarvis.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jarvis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JarvisWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
