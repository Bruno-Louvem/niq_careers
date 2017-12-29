defmodule Careers.Schema do

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      alias Careers.Data.Schema.{
        Profile,
        Account
        }
    end
  end



end
