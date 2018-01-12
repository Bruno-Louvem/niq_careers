defmodule Api.Test.AccountControllerTest do

    use Api.ConnCase

    alias Careers.Data.Model.Account

    test "Do create Account", %{conn: conn} do
        acc_map = %{username: Faker.Name.name,
                  password: Faker.Internet.password(:strong)}
        path = account_path(conn, :create_account, acc_map)
        conn = post(conn, path)
        assert json_response(conn, 200) |> Map.has_key?("accounts_id")
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
        |> Map.get("accounts_id")
        assert account_id == account.id
      end

    test "Do not: get account. Why? no account with id", %{conn: conn} do
        path = account_path(conn, :get_account, Faker.Number.digits)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do not: get account. Why? id is not a number", %{conn: conn} do
        path = account_path(conn, :get_account, Faker.Helper.letterify("###"))
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do: update accounts password", %{conn: conn} do
        pass = Faker.Internet.password(:strong)
        {:ok, account} = Account.create(
          Faker.Name.name(),
          Faker.Internet.password(:strong))
        acc_map = %{id: account.id, password: pass}

        path = account_path(conn, :update_account, acc_map)
        conn = post(conn, path)
        assert new_password = json_response(conn, 200)
        |> Map.get("password")
        assert pass == new_password
    end


end
