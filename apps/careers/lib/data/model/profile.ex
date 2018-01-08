defmodule Careers.Data.Model.Profile do
    use Careers.Model

    alias Careers.Data.Schema.Profile, as: Schema
    alias Careers.Data.Schema.Account

    def create(account_id, email, phone, birth_date) do
      do_create(Schema, %{
        accounts_id: account_id,
        email: email,
        phone: phone,
        birth_date: birth_date
        }, Repo)
      end

      def update(profile_id, changes) when is_map(changes) do
        Schema
        |> Repo.get(profile_id)
        |> Schema.changeset(changes, :update)
        |> __commit_if_valid(:update, Repo)
      end

      def get(profile_id) do

        profile = Repo.get(Schema, profile_id)
        case profile do
          nil -> {:error}
          _ -> profile
        end

      end

      defp do_create(schema, query_fields, repo) when is_map(query_fields) do
        schema.__struct__
        |> schema.changeset(query_fields, :create)
        |> __commit_if_valid(:create, repo)
      end

      defp __commit_if_valid(changeset, operation, repo) do
        if changeset.valid? do
          {status, result} =
            case operation do
              :create -> repo.insert(changeset)
              :update -> repo.update(changeset)
            end
            {status, result}
          else
            {:error, changeset.errors}
          end
        end
end
