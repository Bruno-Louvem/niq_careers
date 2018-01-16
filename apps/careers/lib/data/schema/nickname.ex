defmodule Careers.Data.Schema.Nickname do
    use Careers.Schema

    alias Careers.Data.Schema.Profile

    schema "nickname" do
        belongs_to :profile, Profile

        field :nickname, :string
        field :is_active, :boolean, defalt: false
        timestamps()
    end

    @create_fields [:profile_id, :nickname, :is_active]
    @update_fields [:is_active]

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
    end
end
