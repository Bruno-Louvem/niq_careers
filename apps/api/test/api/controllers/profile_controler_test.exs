defmodule Api.Test.ProfileControllerTest do
    use Api.ConnCase

    import Careers.Test.Support.Factory

    alias Careers.Data.Model.Profile

    setup :account

    test "Do: create Profile", %{conn: conn, account: account} do
        pro_map = %{accounts_id: account.id,
                    email: Faker.Internet.email,
                    phone: Faker.Phone.cell,
                    birth_date: Faker.Date.birthday}
        path = profile_path(conn, :create_profile, pro_map)
        conn = post(conn, path)
        assert json_response(conn, 200) |> Map.has_key?("profiles_key")
    end

    test "Do not: crete profile. Why? Request without required fields",
                            %{conn: conn, account: account} do
         pro_map = %{accounts_id: account.id,
                     email: Faker.Internet.email,
                     birth_date: Faker.Date.birthday}
         path = profile_path(conn, :create_profile, pro_map)
         conn = post(conn, path)
         assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do: get a Profile", %{conn: conn, account: account} do
        {:ok, profile} = Profile.create(account.id,
                    Faker.Internet.email,
                    Faker.Phone.cell,
                    Faker.Date.birthday)

        path = profile_path(conn, :get_profile, profile.id)
        conn = get(conn, path)
        assert profiles_key = json_response(conn, 200) |> Map.get("profiles_key")
        assert profiles_key == profile.id
    end

    test "Do not: get a Profile. Why? No profile wth that id", %{conn: conn} do
        path = profile_path(conn, :get_profile, Faker.Number.digits)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do not: get a Profile. Why Id is invalid", %{conn: conn} do
        path = profile_path(conn, :get_profile, Faker.Lorem.characters)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")

    end

end
