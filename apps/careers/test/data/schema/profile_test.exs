defmodule Careers.Test.Data.Schema.Profile do
    use Careers.Test.Support

    alias Careers.Data.Schema.Profile
    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    setup :account

    test "Do: Create profile with required fields", context do
      changeset = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: Faker.Date.birthday
      })
    assert {:ok, _} = Repo.insert(changeset)
    end

    test "Do not: create profile. Why? email field missing", context do
        changeset = Profile.changeset(%Profile{},%{
          account_id: context.account.id,
          phone: Faker.Phone.cell,
          birth_date: FakerElixir.Date.birthday
        })

    refute changeset.valid?
    end

    test "Do not: Create profile. Why? email field invalid", context do
      changeset = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Lorem.characters,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })
    refute changeset.valid?
    end

    test "Do not: create profile. Why? phone field missing", context do
        changeset = Profile.changeset(%Profile{},%{
          account_id: context.account.id,
          email: Faker.Internet.email,
          birth_date: FakerElixir.Date.birthday
        })

    refute changeset.valid?
    end

    test "Do not: create profile. Why? birth_date field missing", context do
        changeset = Profile.changeset(%Profile{},%{
          account_id: context.account.id,
          email: Faker.Internet.email,
          phone: Faker.Phone.cell,
        })

    refute changeset.valid?
    end

    test "Do not: create profile. Why? account_id field missing" do
        changeset = Profile.changeset(%Profile{},%{
          email: Faker.Internet.email,
          phone: Faker.Phone.cell,
          birth_date: FakerElixir.Date.birthday
        })

    refute changeset.valid?
  end

    test "Do not: create profile. Why? email already in database", context do
      changeset_1 = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: "uiuiu@uhjuhu.com" ,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

      Repo.insert(changeset_1)
      changeset_2 = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: "uiuiu@uhjuhu.com",
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

    assert {:error,_} = Repo.insert(changeset_2)
    end

    test "Do not: create profile. Why? account_id already in database", context do
      changeset_1 = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

      {:ok, profile} = Repo.insert(changeset_1)

      changeset_2 = Profile.changeset(%Profile{},%{
        account_id: profile.id,
        email: Faker.Internet.email,
        phone: nil,
        birth_date: FakerElixir.Date.birthday
      })

    assert {:error,_} = Repo.insert(changeset_2)
    end

    test "Do: update profile's email", context do
      changeset = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

      assert {:ok, profile} = Repo.insert(changeset)
        changeset_update = Profile.changeset(profile, %{
            email: Faker.Internet.email
        }, :update)

        assert {:ok, _} = Repo.update(changeset_update)
    end

    test "Do: update profile's phone", context do
      changeset = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

      assert {:ok, profile} = Repo.insert(changeset)

        changeset_update = Profile.changeset(profile, %{
            phone: Faker.Phone.cell
        }, :update)

        assert {:ok, _} = Repo.update(changeset_update)
    end

    test "Do: update profile's birth_date", context do
      changeset = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

      assert {:ok, profile} = Repo.insert(changeset)

      changeset_update = Profile.changeset(profile, %{
            birth_date: FakerElixir.Date.birthday
        }, :update)

      assert {:ok, _} = Repo.update(changeset_update)
    end

    test "Do: update all updatable fields", context do
      changeset = Profile.changeset(%Profile{},%{
        account_id: context.account.id,
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
      })

      assert {:ok, profile} = Repo.insert(changeset)

      changeset_update = Profile.changeset(profile, %{
        email: Faker.Internet.email,
        phone: Faker.Phone.cell,
        birth_date: FakerElixir.Date.birthday
        }, :update)

      assert {:ok, _} = Repo.update(changeset_update)
    end
end
