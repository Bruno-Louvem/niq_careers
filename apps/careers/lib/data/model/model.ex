defmodule Careers.Model do

  defmacro __using__(_) do
    quote do
      import Ecto.Query

      alias Careers.Repo
    end
  end

end
