defmodule Careers.Data.Schema.ProfileJob do
    use Careers.Schema

    schema "profiles_job" do
        belongs_to :profiles, Profile
        #belongs_to :jobs, Job
        #belongs_to :results, Result

        field :dates, :string
        timestamps()

    end

    @create_fields [:profiles_id, :dates]
    @update_fields [:dates]

    def create_fields, do: @create_fields
    def update_fields, do: @update_fields

    def changeset(instance, params, operation \\ :create)
    def changeset(instance, params, :create) do
       do_changeset(instance, params, @create_fields)
    end
    def changeset(instance, params, :update) do
        do_changeset(instance, params, @update_fields)
    end

    defp do_changeset(instance, params, fields) do
      instance
      |> cast(params, fields)
      |> validate_required(fields)
      |> foreign_key_constraint(:profiles_id)
      #|> foreign_key_constraint(:jobs_id)
      #|> foreign_key_constraint(:results_id)
    end
end
