defmodule Careers.Test.Support do

    defmacro __using__(_) do
        quote do
            use ExUnit.Case
            use Ecto.Schema

            import Ecto.Changeset
            import Ecto.Query
            import Careers.Test.Support.Factory

            alias FakerElixir, as: Faker
            alias Careers.Repo
            alias Careers.{
                Exams,
                Account}
        end
    end
end
