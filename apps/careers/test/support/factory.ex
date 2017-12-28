defmodule Careers.Test.Support.Factory do
    @moduledoc false
    #alias FakerELixir, as: Faker
    alias Careers.Repo
    alias Careers.Data.Schema.Account

    def account(context) do
      changes = %{
        username: FakerElixir.Name.name(),
        password: FakerElixir.Internet.password(:strong)
      }

      {:ok, account} =
        %Account{}
        |> Account.changeset(changes)
        |> Repo.insert()

      [account: account]
    end

end
