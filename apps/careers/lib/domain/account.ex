defmodule Careers.Account do
  use Careers.Domain

  alias Careers.Data.Model.Account, as: Model

      @spec create(String.t, String.t) :: {Atom, Map}

      def create(user, password) do
        Model.create(user, password)
      end

      @spec get(Integer, opts :: Map) :: {Interger, Map}

      def get(account_id, opts \\ %{}) do
        account = Model.get(account_id)

        case account do
            nil -> {:error, "Invalid account id"}
            _ -> {:ok, account}
        end
      end

      @spec update(Interger, Map) :: {Atom, Map}

      def update(account_id, password) when is_map(password) do
        Model.update(account_id, password)
      end
end
