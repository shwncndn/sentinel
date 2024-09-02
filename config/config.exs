# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and is restricted to
# this project.
import Config

# Configuration files are applied in the following order:
#
# 1. config/config.exs
# 2. config/target.exs
# 3. config/target/<platform>.exs
# 4. config/env/<environment>.exs

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :sentinel,
  target: Mix.target(),
  env: Mix.env(),
  generators: [timestamp_type: :utc_datetime]

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.
config :logger, backends: [RingLogger]

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1725271462"

# Configures the endpoint
config :sentinel, SentinelWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: SentinelWeb.ErrorHTML, json: SentinelWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Sentinel.PubSub,
  live_view: [signing_salt: "BOTriGhU"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  sentinel: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  sentinel: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

if Mix.target() != :host,
  do: import_config("target.exs")

import_config "target/#{Mix.target()}.exs"
import_config "env/#{Mix.env()}.exs"
