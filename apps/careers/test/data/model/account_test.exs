defmodule Careers.Test.Data.Model.Account do

    use Careers.Test.Support

    alias Careers.Data.Model.Account

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    end

    test "Do: create account" do
      assert {:ok, _} = Account.create(
          Faker.Name.name(),
          Faker.Internet.password(:strong))
    end

    test "Do not: create account Why? Missing required fields" do
      assert {:error, _} = Account.create(
          Faker.Name.name(), nil)
    end

    test "Do: update account" do
      {:ok, account} = Account.create(
          Faker.Name.name(),
          Faker.Internet.password(:strong))
      new_password = Faker.Internet.password(:strong)

      assert {:ok, updated_account} = Account.update(account.id,
              %{password: new_password})
      assert updated_account.password == new_password
    end

    test "Do: get account" do
      {:ok, account} = Account.create(
         Faker.Name.name(),
         Faker.Internet.password(:strong))

       get_account = Account.get(account.id)
       assert account.id == get_account.id
    end

end
