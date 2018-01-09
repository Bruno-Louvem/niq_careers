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

    def get_profile(conn, %{"id" => profile_id}) do
        profile = do_get_profile(profile_id)
        case profile do
            {:ok, profile} -> render(conn, "profile.json", profile: profile.id)
            {:error, message, code} ->
                conn
                |> put_status(code)
                |> put_view(Api.ErrorView)
                |> render("#{code}.json", message)
        end
    end

    defp do_get_profile(profile_id) do
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
    defp do_create_profile(params) do
        changeset = create_profiles(params)
        with {:ok, data} <- extract_changeset_data(changeset),
             {:ok, payload} <- Profile.create(data.accounts_id,
                                              data.email,
                                              data.phone,
                                              data.birth_date)
        do
             {:ok, payload}
        else
            {:error, message} ->
             {:error, message, 500}
        end
    end
end
