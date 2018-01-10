defmodule Careers.Data.Model.Account do
  use Careers.Model
  alias Careers.Data.Schema.Account, as: Schema

    def create(user, password) do
      fields = %{username: user, password: password}
      do_create(Schema, fields, Repo)
      end

      def update(account_id, password) when is_map(password) do
        Schema
        |> Repo.get(account_id)
        |> Schema.changeset(password, :update)
        |> __commit_if_valid(:update, Repo)
      end

      def get(account_id) do

        Repo.get(Schema, account_id)

      end

      defp do_create(schema, query_fields, repo) when is_map(query_fields) do
        schema.__struct__
        # |> Repo.preload([:profiles])
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
