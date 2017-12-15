defmodule Careers.Mixfile do
    use Mix.Project

    def project do
    [
      app: :careers,
      version: "0.1.0",
      elixir: "~> 1.5.0",
      start_permanent: Mix.env == :prod,
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env),
      deps: deps()
    ]
    end

    # Run "mix help compile.app" to learn about applications.
    def application do
    [
      extra_applications: [:logger]
    ]
    end

    def elixirc_paths(:test), do: ["lib", "test/support"]
    def elixirc_paths(:local), do: ["lib", "test/support"]
    def elixirc_paths(_), do: ["lib"]

    # Run "mix help deps" to learn about dependencies.
    defp deps do
        [
            {:faker_elixir_octopus, "~> 1.0.0",  only: non_production()},
            {:postgrex, ">= 0.0.0"},
            {:ecto, "~> 2.1"}
        ]
    end

    defp non_production, do: [:local, :test]

end
