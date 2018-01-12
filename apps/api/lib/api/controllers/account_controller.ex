defmodule Api.AccountController do
  use Api, :controller

  import Api.Validators.Account
  import Plug.Conn
  import Phoenix.Controller
  import Api.Helpers

  alias Api.Helpers
  alias Careers.Account

  def create_account(conn, params) do
      case do_create_account(params) do
          {:ok, payload} ->
              render(conn, "create_account.json", payload: payload.id)
          {:error, message, code} ->
              conn
              |> put_status(code)
              |> put_view(Api.ErrorView)
              |> render("#{code}.json", %{error: message})
      end
  end

  defp do_create_account(params) do
      changeset = create_accounts(params)
      with {:ok, data}    <- extract_changeset_data(changeset),
           {:ok, payload} <- Account.create(data.username, data.password)
      do
          {:ok, payload}
      else
          {:error, message} ->
              {:error, message, 500}
      end
  end

  def update_account(conn, %{"id" => accounts_id, "password" => password}) do
      {:ok, account} = Account.update(accounts_id, %{password: password})
      render(conn, "updated_account.json", account: account)
  end

  def get_account(conn, %{"id" => accounts_id}) do
    acc_id = do_get_account(accounts_id)
    case acc_id do
      {:ok, account} -> render(conn, "account.json", account: account)

      {:error, message, code} ->
        conn
        |> put_status(code)
        |> put_view(Api.ErrorView)
        |> render("#{code}.json", message)
    end
  end

  defp do_get_account(accounts_id) do
      case Integer.parse accounts_id do
        :error -> {:error, %{error: "Not valid"}, 500}
        {id, _} ->
                    case Account.get(id) do
                      {:ok, id} -> {:ok, id}
                      {:error, "Invalid account id"} ->  {:error, %{error: "Invalid account id"}, 500}
                    end
      end
  end
end
