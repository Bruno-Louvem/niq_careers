defmodule Api.ProfileView do
    use Api, :view

    def render("create_profile.json", %{payload: profiles_key}) do
        %{profiles_key: profiles_key}
    end

    def render("profile.json", %{profile: profiles_key}) do
        %{profiles_key: profiles_key}
    end
end
