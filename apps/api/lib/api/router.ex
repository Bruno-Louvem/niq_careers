defmodule Api.Router do
  use Api, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Api do
    pipe_through :api # Use the default browser stack

    get "/", ApiController, :index

    get "/accounts/:id", AccountController, :get_account

    post "/accounts/update", AccountController, :update_account

    post "/accounts", AccountController, :create_account

    get "/profiles/:id", ProfileController, :get_profile

    post "/profiles/update", ProfileController, :update_profile

    post "/profiles", ProfileController, :create_profile

    get "/profiles/nickname/:id", ProfileController, :get_nickname

    post "/profiles/nickname/update", ProfileController, :update_nickname
  end

  # Other scopes may use custom stacks.
  # scope "/api", Api do
  #   pipe_through :api
  # end
end
