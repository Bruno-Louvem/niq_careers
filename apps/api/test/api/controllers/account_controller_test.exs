defmodule Api.Test.AccountControllerTest do

    use Api.ConnCase

    alias Careers.Data.Model.Account

    test "Do create Account", %{conn: conn} do
        acc_map = %{username: Faker.Name.name,
                  password: Faker.Internet.password(:strong)}
        path = account_path(conn, :create_account, acc_map)
        conn = post(conn, path)
        assert json_response(conn, 200) |> Map.has_key?("accounts_key")
    end


    test "Do not: Create account Why? request without required fields",
                                                        %{conn: conn} do
        acc_map = %{username: Faker.Name.name}
        path = account_path(conn, :create_account, acc_map)
        conn = post(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do: get account", %{conn: conn} do
        {:ok, account} = Account.create(
          Faker.Name.name(),
          Faker.Internet.password(:strong))

        path = account_path(conn, :get_account, account.id)
        conn = get(conn, path)
        assert account_id = json_response(conn, 200)
        |> Map.get("accounts_key")
        assert account_id == account.id
      end

    test "Do not: get account. Why? no account with id", %{conn: conn} do
        path = account_path(conn, :get_account, Faker.Number.digits)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do not: get account. Why? id is not a number", %{conn: conn} do
        path = account_path(conn, :get_account, Faker.Lorem.characters)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

end
