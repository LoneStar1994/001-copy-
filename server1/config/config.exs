# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :server1,
  ecto_repos: [Server1.Repo]

# Configures the endpoint
config :server1, Server1.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7Zur6jV6MuSeswXt1IakHP/gUZwjWD7PU2K6Q/6XASWemY1FHB+6SqmT6fe5cFi4",
  render_errors: [view: Server1.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Server1.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
