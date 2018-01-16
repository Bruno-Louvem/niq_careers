defmodule Api.ProfileView do
    use Api, :view

    def render("create_profile.json", %{payload: profiles}) do
        %{profiles_id: profiles}
    end

    def render("profile.json", %{profiles_id: profiles, profile_phone: phone,
                                profile_email: email, nick_active: nickname}) do
        %{nick_active: nickname, profiles_id: profiles,
            profile_email: email, profile_phone: phone}
    end

    def render("nickname.json", %{nicknames: nickname}) do
        %{nicknames: nickname}
    end

    def render("updated_profile.json", %{id: profile_id,
                                           email: profile_email,
                                           phone: profile_phone,
                                           birth_date: profile_birth_date}) do
        %{profile_id: profile_id, profile_email: profile_email,
          profile_phone: profile_phone, profile_birth_date: profile_birth_date}
    end

    def render("update_nickname.json", %{profile_id: profile_id,
                                          nicknames: nicknames}) do
        %{profile_id: profile_id, nicknames: nicknames}
    end
end
