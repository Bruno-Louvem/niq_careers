use Mix.Config

config :careers, Careers.Repo,
    adapter: Ecto.Adapters.Postgres,
    url: System.get_env("DATABASE_URL"),
    pool: Ecto.Adapters.Postgres

config :logger, level: :info
