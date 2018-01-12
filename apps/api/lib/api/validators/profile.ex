defmodule Api.Validators.Profile do
    use Params

    defparams create_profiles %{
        accounts_id!: :string,
        email!: :string,
        phone!: :string,
        birth_date!: :string,
        nickname: :string}

end
