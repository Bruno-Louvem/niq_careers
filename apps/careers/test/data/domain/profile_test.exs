defmodule Careers.Test.Data.Domain.Profile do
    use Careers.Test.Support

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    setup :account

    test "Do: create profile", context do
        assert {:ok, _} = Profile.create(
                context.account.id,
                Faker.Internet.email,
                Faker.Phone.cell,
                Faker.Date.birthday)

    end

    test "Do not: create profile. Why? blanked required field", context do

        assert {:error, _} = Profile.create(
              context.account.id,
              Faker.Internet.email,
              Faker.Phone.cell,
              nil)

        assert {:error, _} = Profile.create(
              context.account.id,
              Faker.Internet.email,
              nil,
              Faker.Date.birthday)

        assert {:error, _} = Profile.create(
              context.account.id,
              nil,
              Faker.Phone.cell,
              Faker.Date.birthday)

        assert {:error, _} = Profile.create(
              nil,
              Faker.Internet.email,
              Faker.Phone.cell,
              Faker.Date.birthday)

    end




    test "Do: update profile", context do
      {:ok, profile} = Profile.create(
              context.account.id,
              Faker.Internet.email,
              Faker.Phone.cell,
              Faker.Date.birthday)

      update_fields = %{email: Faker.Internet.email,
          phone: Faker.Phone.cell,
          birth_date: Faker.Date.birthday}

      assert {:ok, updated_profile} = Profile.update(profile.id,
                                                    update_fields)

      assert updated_profile.email == update_fields.email
      assert updated_profile.phone == update_fields.phone
      assert updated_profile.birth_date == update_fields.birth_date
    end

    test "Do not: update profile. Why? empty field inside changes", context do
      {:ok, profile} = Profile.create(
              context.account.id,
              Faker.Internet.email,
              Faker.Phone.cell,
              Faker.Date.birthday)

      update_fields_1 = %{email: Faker.Internet.email, phone: nil,
          birth_date: Faker.Date.birthday}

      update_fields_2 = %{email: Faker.Internet.email, phone: Faker.Phone.cell,
          birth_date: nil}

      update_fields_3 = %{email: nil, phone: Faker.Phone.cell,
          birth_date: Faker.Date.birthday}


      assert {:error, _} = Profile.update(profile.id, update_fields_1)
      assert {:error, _} = Profile.update(profile.id, update_fields_2)
      assert {:error, _} = Profile.update(profile.id, update_fields_3)
    end

    test "Do: get profile", context do
      accounts_id = context.account.id
      email = Faker.Internet.email
      phone = Faker.Phone.cell
      birth_date = Faker.Date.birthday

      {:ok, profile} = Profile.create(
              accounts_id,
              email,
              phone,
              birth_date)

      assert profile == Profile.get(profile.id)
      assert email == Profile.get(profile.id, :email)
      assert phone == Profile.get(profile.id, :phone)
      assert accounts_id == Profile.get(profile.id, :account_id)
      assert birth_date == Profile.get(profile.id, :birth_date)



    end

    test "Do not: get profile. Why? invalid profile id", context do

      assert {:error} == Profile.get(Faker.Number.digits(4), :all)

    end

end
