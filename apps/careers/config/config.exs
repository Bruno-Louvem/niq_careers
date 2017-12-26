use Mix.Config

config :careers,
  ecto_repos: [Careers.Repo]

config :logger, :console,
  format: "$time $metadata[$level] $message\n"

import_config "#{Mix.env}.exs"
