# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :hangman, HangmanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JF7FYPQtBKHNeakLe1xES6jB5oLYmBk6EkLm5nbUq9JXlAS8licCxSJz0SK1pxBU",
  render_errors: [view: HangmanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hangman.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "2Po884zQAmcxAUlYVxZU3G41ddUPwK5iIohxaXRGvpfjMkRCtV31SJUK2YgjkpZ2"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Enable LiveView
config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
