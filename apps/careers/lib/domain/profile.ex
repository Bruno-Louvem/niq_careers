defmodule Careers.Profile do
  use Careers.Domain
  alias Careers.Data.Model.Profile, as: Model

  @spec create(String.t, String.t, String.t, String.t, String.t) :: {Atom, Map}

    def create(account_id, email, phone, birth_date, nickname) do
        list = [account_id, email, phone, birth_date, nickname]
      verify =
      case Enum.member?(list, nil) do
          true -> nil
          false -> :ok
      end
      case verify do
        nil -> {:error, "Blanked fields"}
        :ok ->
        Model.create(account_id, email, phone, birth_date, nickname)
      end
    end

    @spec get(Integer, opts :: Map) :: {Atom, Map}

    def get(profile_id, opts \\ :all) do
      profile = Model.get(profile_id)
      case profile do

        {:error} -> {:error}
        _ -> {:ok, profile}
      end

      case opts do
        :all -> Model.get(profile_id)
        :email -> profile.email
        :phone -> profile.phone
        :account_id -> profile.account_id
        :birth_date -> profile.birth_date
      end

    end

    @spec update(Interger, Map) :: {Atom, Map}

    def update(profile_id, changes) when is_map(changes) do
      case changes.email do
        nil -> {:error, nil}
            _ -> case changes.phone do
        nil -> {:error, nil}
            _ -> case changes.birth_date do
        nil -> {:error, nil}
        _ -> Model.update(profile_id, changes)
              end
          end
      end
    end

    @spec update_nickname(Interger, String.t) :: {Atom, List}

    def update_nickname(profile_id, nickname) do
        case Model.get(profile_id) do
            {:error} -> {:error, "No profile with that id"}
            profile -> Model.update_nickname(profile.id, nickname)
        end
    end

    @spec get_nickname(Interger) :: {List}

    def get_nickname(profile_id, opt\\ :is_active) do
        case Model.get(profile_id) do
            {:error} -> {:error, "No profile with that id"}
            profile -> Model.get_nickname(profile.id, opt)
        end
    end
end
