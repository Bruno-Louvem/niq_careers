defmodule Careers.Test.Data.Domain.Account do
    use Careers.Test.Support

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    test "Do: create account" do
        assert {:ok, _} = Account.create(
        Faker.Name.name(),
        Faker.Internet.password(:strong)
        )
    end

    test "Do: update account" do
      {:ok, account} = Account.create(
          Faker.Name.name(),
          Faker.Internet.password(:strong)
          )
      new_password = Faker.Internet.password(:strong)

      assert {:ok, updated_account} = Account.update(account.id,
              %{password: new_password})
      assert updated_account.password == new_password

    end

    test "Do: get account" do
      {:ok, account} = Account.create(
          Faker.Name.name(),
          Faker.Internet.password(:strong)
          )
      get_account = Account.get(account.id)
      assert {:ok, account} == get_account
    end

end
