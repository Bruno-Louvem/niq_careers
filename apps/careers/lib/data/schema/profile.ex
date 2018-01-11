defmodule Careers.Data.Schema.Profile do
    use Careers.Schema

    alias Careers.Data.Schema.Account
    alias Careers.Data.Schema.Nickname

      schema "profiles" do
        belongs_to :account, Account

        has_many :nickname, Nickname
        #has_many :profile_jobs, ProfileJob

        field :email, :string
        field :phone, :string
        field :birth_date, :string
        field :is_admin, :boolean, default: false
        timestamps()

      end

      @create_fields [:account_id, :email, :phone, :birth_date]
      @update_fields [:email, :phone, :birth_date]

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
        |> validate_format(:email, ~r/@/)
        |> unique_constraint(:email, [message: "e-mail already in database"])
        |> foreign_key_constraint(:account_id)
      end
end
