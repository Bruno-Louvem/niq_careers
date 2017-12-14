use Mix.Config

config :careers,
  ecto_repos: [Careers.Repo]

import_config "#{Mix.env}.exs"
