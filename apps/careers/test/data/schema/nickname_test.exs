defmodule Careers.Test.Data.Schema.Nickname do
    use Careers.Test.Support

    alias Careers.Data.Schema.Nickname

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    setup :account
    setup :profile

    test "Do: create nickname", context do
        changeset = Nickname.changeset(%Nickname{}, %{
            profile_id: context.profile.id,
            nickname: Faker.Name.name})

        assert {:ok, _} = Repo.insert(changeset)
    end

    test "Do not: create nickname Why? required fields missing", context do
        changeset = Nickname.changeset(%Nickname{}, %{
            nickname: Faker.Name.name})

        assert {:error, _} = Repo.insert(changeset)
    end

    test "Do: update active nickname", %{profile: profile} do
        changeset = Nickname.changeset(%Nickname{}, %{
            profile_id: profile.id,
            nickname: Faker.Name.name})

        assert {:ok, nickname} = Repo.insert(changeset)

        changeset_1 = Nickname.changeset(nickname, %{
            is_active: true}, :update)
        assert changeset_1.valid?
    end

    test "Do not: update active nickname", %{profile: profile} do
        changeset = Nickname.changeset(%Nickname{}, %{
            profile_id: profile.id,
            nickname: Faker.Name.name})

        assert {:ok, nickname} = Repo.insert(changeset)

        changeset_1 = Nickname.changeset(nickname, %{}, :update)
        refute changeset_1.valid?
    end


end
