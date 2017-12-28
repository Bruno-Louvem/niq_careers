defmodule Careers.Schema do

    defmacro __using__(_) do
      quote do
        use Ecto.Schema
        import Ecto.Changeset
        import Careers.Data.Support.Error
      end
    end
end
