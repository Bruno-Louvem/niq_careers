defmodule Api.Test.ProfileControllerTest do
    use Api.ConnCase

    import Careers.Test.Support.Factory

    alias Careers.Data.Model.Profile

    setup :account

    test "Do: create Profile", %{conn: conn, account: account} do
        pro_map = %{accounts_id: account.id,
                    email: Faker.Internet.email,
                    phone: Faker.Phone.cell,
                    birth_date: Faker.Date.birthday,
                    nickname: Faker.Lorem.characters}
        path = profile_path(conn, :create_profile, pro_map)
        conn = post(conn, path)
        assert json_response(conn, 200) |> Map.has_key?("profiles_id")
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
                    Faker.Date.birthday,
                    Faker.Lorem.characters)
        Careers.Profile.update_nickname(profile.id, Faker.Lorem.characters)
        Careers.Profile.update_nickname(profile.id, Faker.Lorem.characters)
        Careers.Profile.update_nickname(profile.id, Faker.Lorem.characters)
        Careers.Profile.update_nickname(profile.id, Faker.Lorem.characters)
        path = profile_path(conn, :get_profile, profile.id)
        conn = get(conn, path)

        assert profiles_key = json_response(conn, 200) |> Map.get("profiles_id")
        assert profiles_key == profile.id
        assert json_response(conn, 200) |> Map.has_key?("nick_active")
    end

    test "Do not: get a Profile. Why? No profile wth that id", %{conn: conn} do
        path = profile_path(conn, :get_profile, Faker.Number.digits)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do not: get a Profile. Why Id is invalid", %{conn: conn} do
        path = profile_path(conn, :get_profile, Faker.Helper.letterify("###"))
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test " Do: get Nickname", %{conn: conn, account: account} do
        {:ok, profile} = Profile.create(account.id,
                    Faker.Internet.email,
                    Faker.Phone.cell,
                    Faker.Date.birthday,
                    Faker.Lorem.characters)
        path = profile_path(conn, :get_nickname, profile.id)
        conn = get(conn, path)
        assert json_response(conn, 200) |> Map.has_key?("nicknames")
    end

    test " Do not: get Nickname, Why? invalid profile", %{conn: conn} do

        path = profile_path(conn, :get_nickname, Faker.Number.digits)
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test " Do not: get Nickname, Why? invalid profile id", %{conn: conn} do

        path = profile_path(conn, :get_nickname, Faker.Helper.letterify("###"))
        conn = get(conn, path)
        assert json_response(conn, 500) |> Map.has_key?("error")
    end

    test "Do: update profile", %{conn: conn, account: account} do
        email = Faker.Internet.email
        phone = Faker.Phone.cell
        birth_date = Faker.Date.birthday

        {:ok, profile} = Profile.create(account.id,
                    Faker.Internet.email,
                    Faker.Phone.cell,
                    Faker.Date.birthday,
                    Faker.Lorem.characters)
        map = %{id: profile.id,
                email: email,
                phone: phone,
                birth_date: birth_date}

        path = profile_path(conn, :update_profile, map)
        conn = post(conn, path)
        assert new_email = json_response(conn, 200) |> Map.get("profile_email")
        assert new_phone = json_response(conn, 200) |> Map.get("profile_phone")
        assert new_birth_date = json_response(conn, 200) |> Map.get("profile_birth_date")
        assert new_email == email
        assert new_phone == phone
        assert new_birth_date == birth_date
    end

    test "Do: update nickname", %{conn: conn, account: account} do
        nick = Faker.Lorem.characters
        {:ok, profile} = Profile.create(account.id,
                    Faker.Internet.email,
                    Faker.Phone.cell,
                    Faker.Date.birthday,
                    Faker.Lorem.characters)

        path = profile_path(conn, :update_nickname, %{profile_id: profile.id,
                                                      nickname: nick})
        conn = post(conn, path)
        assert json_response(conn, 200) |> Map.has_key?("nicknames")

    end
end
