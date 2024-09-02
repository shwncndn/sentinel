defmodule Sentinel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true

  def start(_type, _args) do
    children =
      [
        SentinelWeb.Telemetry,
        {Phoenix.PubSub, name: Sentinel.PubSub},
        SentinelWeb.Endpoint
        # Children for all targets
        # Starts a worker by calling: Sentinel.Worker.start_link(arg)
        # {Sentinel.Worker, arg},
      ] ++ children(Nerves.Runtime.mix_target())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sentinel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  defp children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Sentinel.Worker.start_link(arg)
      # {Sentinel.Worker, arg},
    ]
  end

  defp children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: Sentinel.Worker.start_link(arg)
      # {Sentinel.Worker, arg},
    ]
  end

  @impl true
  def config_change(changed, _new, removed) do
    SentinelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
