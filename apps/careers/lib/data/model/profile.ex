defmodule Careers.Data.Model.Profile do
    use Careers.Model

    alias Careers.Data.Schema.Profile, as: Schema
    alias Careers.Data.Schema.Nickname

    def create(account_id, email, phone, birth_date, nickname) do

        profile_assert = do_create(Schema, %{
                        account_id: account_id,
                        email: email,
                        phone: phone,
                        birth_date: birth_date
                        }, Repo)
        case profile_assert do
            {:ok, profile} -> do_create(Nickname, %{nickname: nickname,
                                                profile_id: profile.id,
                                                is_active: true}, Repo)
                            {:ok, profile}
            {:error, message} -> {:error, message}
        end
      end

      def update_nickname(profile_id, nickname) do
        {:ok, nickname} = do_create(Nickname, %{nickname: nickname,
                            profile_id: profile_id,
                            is_active: true}, Repo)
        id_list = get_nickname(profile_id, :ids)
        id_list = id_list -- [nickname.id]

        for n <- id_list do
            Nickname
            |> Repo.get(n)
            |> Nickname.changeset(%{is_active: false}, :update)
            |> __commit_if_valid(:update, Repo)
        end
        {:ok, get_nickname(profile_id)}
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
      def get_nickname(pro_id, option \\ :is_active)
      def get_nickname(pro_id, :is_active) do
          nk = []
          query =
            from(
              u in "nickname",
              where: u.profile_id == ^pro_id,
              select: u.id)
          nick_id = Repo.all(query)
          nk ++
          for n <- nick_id do
            nicke = Repo.get(Nickname, n)
            {nicke.nickname, nicke.is_active}
          end
      end
      def get_nickname(pro_id, :ids) do
          list_id = []
          query =
            from(
              u in "nickname",
              where: u.profile_id == ^pro_id,
              select: u.id)
          nick_id = Repo.all(query)
          list_id ++
            for n <- nick_id do
                nicke = Repo.get(Nickname, n)
                nicke.id
            end
      end

      def get_nickname(pro_id, :active) do
            nicknames = get_nickname(pro_id, :is_active)
            var1 =
            for n <- nicknames do
                if elem(n, 1) do
                    n
                end
            end
            Enum.uniq(var1) -- [nil]
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
