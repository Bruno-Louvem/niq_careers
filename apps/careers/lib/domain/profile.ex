defmodule Careers.Profile do
  use Careers.Domain
  alias Careers.Data.Model.Profile, as: Model

  @spec create(String.t, String.t, String.t, String.t) :: {Atom, Map}

    def create(profile_id, email, phone, birth_date) do
      case profile_id do
        nil -> {:error}
        _ -> {:ok, profile_id}
      end
      case email do
        nil -> {:error}
        _ -> {:ok, email}
      end
      case phone do
        nil -> {:error}
        _ -> {:ok, phone}
      end
      case birth_date do
        nil -> {:error}
        _ -> {:ok, birth_date}
      end

      Model.create(profile_id, email, phone, birth_date)
    end

    @spec get(Integer, opts :: Map) :: {Atom, Map}

    def get(profile_id, opts \\ :all) do
      profile = Model.get(profile_id)

      case profile do
        nil -> {:error}
        _ -> {:ok, profile}
      end

      case opts do
        :all -> Model.get(profile_id)
        :email -> profile.email
        :phone -> profile.phone
        :accounts_id -> profile.accounts_id
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
end
