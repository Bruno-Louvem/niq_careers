defmodule Careers.Repo.Migrations.DummyTable do
  use Ecto.Migration

  def change do

        create table (:my_schema) do
          add :name, :string
        end
  end
end
