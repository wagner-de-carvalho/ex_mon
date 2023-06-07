# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ex_mon,
  ecto_repos: [ExMon.Repo]

# Configures the endpoint
config :ex_mon, ExMonWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ExMonWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ExMon.PubSub,
  live_view: [signing_salt: "koQoMEnr"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ex_mon, ExMon.Mailer, adapter: Swoosh.Adapters.Local

# Tesla HTTP client
# config :tesla, adapter: Tesla.Adapter.Hackney

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian token based authentication library
config :ex_mon, ExMonWeb.Auth.Guardian,
  issuer: "ex_mon",
  secret_key: "kiZCcFTvhtoGzbHhzAMlyZ8oC7/xk7fx08Tp34aamo++QZwUTA5w/PzymE74+rL0"

# Plug Pipeline
config :ex_mon, ExMonWeb.Auth.Pipeline,
  module: ExMonWeb.Auth.Guardian,
  error_handler: ExMonWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
