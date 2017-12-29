defmodule Careers.Test.Data.Schema.ProfileJob do
  import Careers.Test.Support

  use Careers.Test.Support.Factory

  alias Careers.Data.Schema.ProfileJob

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
  end

  #setup :profiles
  #setup :jobs
  #setup :results

  test "Do: Create profile_job with required fields", context do
  changeset = Profile.changeset(%Profile{},%{
    accounts_id: context.account.id,
    email: Faker.Internet.email,
    phone: Faker.Phone.cell,
    birth_date: FakerElixir.Date.birthday
  })
assert {:ok, _} = Repo.insert(changeset)
end

end
