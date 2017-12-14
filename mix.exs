defmodule NiQCareers.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     version: "0.1.0",
     elixir: "~> 1.5.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     deps: deps(),
     aliases: aliases()]
  end

  defp deps do
    [
     {:excoveralls, "~> 0.6", only: [:local, :test]},
     {:credo, "~> 0.7", only: [:local, :test]},
     {:distillery, "~> 1.4"},
   ]
  end

  defp aliases do
      
  end
end
