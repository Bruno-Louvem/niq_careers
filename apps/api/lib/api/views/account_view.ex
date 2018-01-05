defmodule Api.AccountView do
    use Api, :view

    def render("create_account.json", %{payload:  accounts_key}) do
        %{accounts_key: accounts_key}
    end
    def render("account.json", %{account:  accounts_key}) do
        %{accounts_key: accounts_key}
    end
end
