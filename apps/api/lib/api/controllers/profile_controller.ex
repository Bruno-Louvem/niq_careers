defmodule Api.ProfileController do
    use Api, :controller

    import Api.Validators.Profile
    import Plug.Conn
    import Phoenix.Controller
    import Api.Helpers

    alias Api.Helpers
    alias Careers.Profile

    def create_profile(conn, params) do
        case do_create_profile(params) do
            {:ok, payload} ->
                render(conn, "create_profile.json", payload: payload.id)
            {:error, message, code} ->
                conn
                |> put_status(code)
                |> put_view(Api.ErrorView)
                |> render("#{code}.json", %{error: message})
        end
    end

    def update_profile(conn, %{"id" => profile_id,
              "email" => email,
              "phone" => phone,
              "birth_date" => birth_date}) do
        map_changes = %{email: email, phone: phone, birth_date: birth_date}
        {:ok, profile} = Profile.update(profile_id, map_changes)
        render(conn, "updated_profile.json", %{id: profile.id,
                                               email: profile.email,
                                               phone: profile.phone,
                                               birth_date: profile.birth_date})

    end

    def update_nickname(conn, %{"profile_id" => profile_id,
                                "nickname" => nickname}) do
        {:ok, nickname} = Profile.update_nickname(profile_id, nickname)
        render(conn, "update_nickname.json", %{profile_id: profile_id,
                                                nicknames: nickname})
    end

    def get_profile(conn, %{"id" => profile_id}) do

        case do_get_profile(profile_id) do
            {:ok, profile} ->
                [{nickname, _}] = Profile.get_nickname(profile.id, :active)
                render(conn, "profile.json", %{profiles_id: profile.id,
                                               profile_phone: profile.phone,
                                               profile_email: profile.email,
                                               nick_active: nickname})

            {:error, message, code} ->
                conn
                |> put_status(code)
                |> put_view(Api.ErrorView)
                |> render("#{code}.json", message)
        end
    end

    def get_nickname(conn, %{"id" => profile_id}) do
        case do_get_profile(profile_id, :nickname) do
            {:ok, nickname} -> render(conn, "nickname.json", %{nicknames: nickname})
            {:error, message, code} ->
                conn
                |> put_status(code)
                |> put_view(Api.ErrorView)
                |> render("#{code}.json", message)
        end
    end
    defp do_get_profile(profile_id, entity \\ :profile)
    defp do_get_profile(profile_id, :profile) do
        case Integer.parse profile_id do
          :error -> {:error, %{error: "Not valid"}, 500}
          {id, _} ->
                    case Profile.get(id) do
                        {:error} ->
                            {:error, %{error: "Invalid profile id"}, 500}
                        profile -> {:ok, profile}
                    end
        end
    end

    defp do_get_profile(profile_id, :nickname) do
        case Integer.parse profile_id do
          :error -> {:error, %{error: "Not valid"}, 500}
          {id, _} ->
                    case Profile.get_nickname(id) do
                        {:error, _} ->
                            {:error, %{error: "Invalid profile id"}, 500}

                        profile -> {:ok, profile}
                    end
        end
    end


    defp do_create_profile(params) do
        changeset = create_profiles(params)
        with {:ok, data} <- extract_changeset_data(changeset),
             {:ok, payload} <- Profile.create(data.accounts_id,
                                              data.email,
                                              data.phone,
                                              data.birth_date,
                                              data.nickname)
        do
             {:ok, payload}
        else
            {:error, message} ->
             {:error, message, 500}
        end
    end
end
