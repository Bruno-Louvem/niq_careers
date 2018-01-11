defmodule Careers.Repo.Migrations.Account do
  use Ecto.Migration

    def change do

      create table("accounts") do
        add :username, :string
        add :password, :string
        timestamps type: :utc_datetime
      end
      create unique_index(:accounts, [:username])
    end
end
