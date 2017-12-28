defmodule Careers.Test.Data.Schema.Account do
    use Careers.Test.Support

    alias Careers.Data.Schema.Account

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    test "Do: Create account" do
          changeset = Account.changeset(%Account{},
          %{username: Faker.Name.name(),
            password: Faker.Internet.password(:strong)
            })

          assert {:ok, _} = Repo.insert(changeset)
    end

    test "Do not: Create account. Why? Username is too short" do
          changeset = Account.changeset(%Account{},
                      %{username: Faker.Lorem.character(),
                      password: Faker.Internet.password(:strong)
                      })

          assert {:error, _} = Repo.insert(changeset)
    end
    test "Do not: Create account. Why? Password is too short" do
          changeset = Account.changeset(%Account{},
                      %{username: Faker.Name.name(),
                      password: Faker.Lorem.character()
                      })

          assert {:error, _} = Repo.insert(changeset)

    end

    test "Do not: Creat account. Why? Missing required field " do
          data = %{username: Faker.Name.name(),
            password: Faker.Lorem.character()
            }
          changeset = Account.changeset(%Account{},
                      Map.drop(data, [:password]))
          assert {:error,_} = Repo.insert(changeset)

          changeset = Account.changeset(%Account{},
                      Map.drop(data, [:usename]))
          assert {:error, _} = Repo.insert(changeset)


    end

    test "Do: Update account's password" do
      changeset =Account.changeset(%Account{},%{
                username: Faker.Name.name(),
                password: Faker.Internet.password(:strong)
                })
      assert {:ok, account} = Repo.insert(changeset)

      changeset_update = Account.changeset(account,
          %{password: Faker.Internet.password(:strong)},
          :update)
      assert {:ok,_} = Repo.update(changeset_update)
    end

end
