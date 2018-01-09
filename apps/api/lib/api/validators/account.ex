defmodule Api.Validators.Account do
    use Params

    defparams create_accounts %{
        username!: :string,
        password!: :string
    }
end
