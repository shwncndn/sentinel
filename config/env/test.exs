import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sentinel, SentinelWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5JDEbgF+J3b4JxnV+Lnk2Awdk5PcjRcsKP234y3zaUB+T5lqI4NK6W/mKmuJePj/",
  code_reloader: false,
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
