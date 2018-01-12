defmodule Careers.Repo.Migrations.Profile do
  use Ecto.Migration

    def change do
      create table ("profiles") do
        add :account_id, references(:accounts), null: false
        #add :nickname, references(:nickname), virtual: true
        add :email, :string
        add :phone, :string
        add :birth_date, :string
        add :is_admin, :boolean, default: false
        timestamps type: :utc_datetime
      end
      create unique_index(:profiles, [:email])
      create unique_index(:profiles, [:account_id])
    end
end
