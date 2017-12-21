defmodule Careers.Domain do

  defmacro __using__(_) do
    quote do
      alias Careers.Data.Model.Account, as: Model
      alias Careers.Repo
      alias FakerElixir, as: Faker
    end
  end
end
