defmodule Api.Router do
  use Api, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Api do
    pipe_through :api # Use the default browser stack

    get "/", ApiController, :index

    get "/accounts/:id", AccountController, :get_account

    post "/accounts/create", AccountController, :create_account

    get "/profiles/:id", ProfileController, :get_profile

    post "/profiles/create", ProfileController, :create_profile
  end

  # Other scopes may use custom stacks.
  # scope "/api", Api do
  #   pipe_through :api
  # end
end
