defmodule Careers.Test.Data.Model.Profile do

  use Careers.Test.Support

  alias Careers.Data.Model.Profile
  alias Careers.Data.Schema.Nickname

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    setup :account

    test "Do: create profile with default options", context do
        assert {:ok, _profile} = Profile.create(
            context.account.id,
            Faker.Internet.email,
            Faker.Phone.cell,
            Faker.Date.birthday,
            Faker.Lorem.characters)
    end

    test "Do not: create profile. Why? Invalid changeset" do
        assert {:error, _} = Profile.create(
        nil,
        Faker.Internet.email,
        Faker.Phone.cell,
        Faker.Date.birthday,
        Faker.Lorem.characters)
    end

    test "Do: update profile", context do
      {:ok, profile} = Profile.create(
          context.account.id,
          Faker.Internet.email,
          Faker.Phone.cell,
          Faker.Date.birthday,
          Faker.Lorem.characters)

      changes = %{email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: Faker.Date.birthday}

      assert {:ok, updated_profile} = Profile.update(profile.id,
              changes)
      assert updated_profile.email == changes.email
      assert updated_profile.phone == changes.phone
      assert updated_profile.birth_date == changes.birth_date
    end

    test "Do: get profile", context do
      {:ok, profile} = Profile.create(
          context.account.id,
          Faker.Internet.email,
          Faker.Phone.cell,
          Faker.Date.birthday,
          Faker.Lorem.characters)

      get_profile = Profile.get(profile.id)
      assert profile == get_profile
    end

    test "Do: get nickname", context do
     nick = Faker.Lorem.characters
     {:ok, profile} = Profile.create(
         context.account.id,
         Faker.Internet.email,
         Faker.Phone.cell,
         Faker.Date.birthday,
         nick)

     changeset = Nickname.changeset(%Nickname{}, %{
         profile_id: profile.id,
         nickname: Faker.Name.name,
         is_active: false})
     assert {:ok, _nickname} = Repo.insert(changeset)

     nicke = Profile.get_nickname(profile.id)
     nk = [] ++
     for n <- nicke do
        elem(n, 0)
     end
     assert Enum.member?(nk, nick)
    end

    test "Do: get active nickname", context do
        nick = Faker.Lorem.characters
        {:ok, profile} = Profile.create(
            context.account.id,
            Faker.Internet.email,
            Faker.Phone.cell,
            Faker.Date.birthday,
            nick)
        assert [{nick, true}] == Profile.get_nickname(profile.id, :active)

    end

    test "Do: update nickname", context do
     nk = Faker.Lorem.character
     nk_1 = Faker.Lorem.character
     {:ok, profile} = Profile.create(
         context.account.id,
         Faker.Internet.email,
         Faker.Phone.cell,
         Faker.Date.birthday,
         nk_1)
     assert {:ok, var} = Profile.update_nickname(profile.id, nk)
     assert Enum.member?(var, {nk, true})
     assert Enum.member?(var, {nk_1, false})
    end

end
