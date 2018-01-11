defmodule Careers.Domain do

    defmacro __using__(_) do
      quote do
        import Ecto.Query

        alias Careers.Repo
        alias FakerElixir, as: Faker
      end
    end
end
