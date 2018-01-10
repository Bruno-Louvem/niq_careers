defmodule Careers.Test.Support.Factory do
    @moduledoc false
    #alias FakerELixir, as: Faker
    alias Careers.Repo
    alias Careers.Data.Schema.Account
    alias Careers.Data.Schema.Profile

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

    def profile(context) do
        changes = %{
            account_id: context.account.id,
            email: FakerElixir.Internet.email,
            phone: FakerElixir.Phone.cell,
            birth_date: FakerElixir.Date.birthday}

        {:ok, profile} =
            %Profile{}
            |> Profile.changeset(changes)
            |> Repo.insert

        [profile: profile]
    end
end
