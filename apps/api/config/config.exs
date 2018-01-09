# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: Api

# Configures the endpoint
config :api, Api.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WByhamoUgt5gR4dWOKVRddhFuEe0FqtwkznpGT0xMVZNcJgptkAyY79pEMFP4XJ6",
  render_errors: [view: Api.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Api.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :api,
    ecto_repos: [Careers.Repo]


import_config "#{Mix.env}.exs"
