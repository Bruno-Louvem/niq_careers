defmodule Api.AccountView do
    use Api, :view

    def render("create_account.json", %{payload:  accounts_id}) do
        %{accounts_key: accounts_id}
    end

    def render("account.json", %{account:  account}) do
        %{accounts_id: account.id, username: account.username}
    end
end
