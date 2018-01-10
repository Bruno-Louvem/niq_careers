defmodule Careers.Repo.Migrations.Nickname do
    use Ecto.Migration

    def change do

        create table ("nickname") do
            add :profile_id, references(:profiles), null: false
            add :nickname, :string
            add :is_active, :boolean, default: false
            timestamps type: :utc_datetime
        end
    end
end
