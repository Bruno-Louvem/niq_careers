defmodule Careers.Test.Data.Model.Profile do

  use Careers.Test.Support

  alias Careers.Data.Model.Profile

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
            Faker.Date.birthday
        )
    end

    test "Do: update profile", context do
      {:ok, profile} = Profile.create(
          context.account.id,
          Faker.Internet.email,
          Faker.Phone.cell,
          Faker.Date.birthday
      )
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
          Faker.Date.birthday
      )
      get_profile = Profile.get(profile.id)
      assert profile == get_profile
    end

end
