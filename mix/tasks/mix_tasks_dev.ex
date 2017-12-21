defmodule Mix.Tasks.Dev.Resetdb do
    use Mix.Task

    def run(_) do
        System.cmd "mix", ["ecto.drop"],
            stderr_to_stdout: true,
            into: IO.stream(:stdio, :line)

        System.cmd "mix", ["ecto.create"],
            stderr_to_stdout: true,
            into: IO.stream(:stdio, :line)

        System.cmd "mix", ["ecto.migrate"],
            stderr_to_stdout: true,
            into: IO.stream(:stdio, :line)
    end
end
