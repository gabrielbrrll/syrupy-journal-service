# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :syrupy_api,
  ecto_repos: [SyrupyApi.Repo]

# Configures the endpoint
config :syrupy_api, SyrupyApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SyrupyApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SyrupyApi.PubSub,
  live_view: [signing_salt: "8EtSTthn"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :syrupy_api, SyrupyApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :syrupy_api, SyrupyApi.Guardian,
  issuer: "syrupy_api",
  secret_key: "YOUR_SECRET_KEY"
