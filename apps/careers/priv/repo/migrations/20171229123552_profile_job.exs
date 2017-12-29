defmodule Careers.Repo.Migrations.ProfileJob do
  use Ecto.Migration

  def change do

    create table ("profiles_job") do
      add :profiles_id, references(:profiles), null: false
      #add :jobs_id, references(:jobs), null: false
      add :dates, :string
      #add :result_id, references(:results), null: false
      timestamps type: :utc_datetime
    end
    create unique_index(:profiles_job, [:profiles_id])
    #create unique_index(:profiles_job, [:jobs_id])
    #create unique_index(:profiles_job, [:results_id])

  end
end
