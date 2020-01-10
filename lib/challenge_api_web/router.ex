defmodule ChallengeApiWeb.Router do
  use ChallengeApiWeb, :router
  alias ChallengeApi.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Guardian.AuthPipeline
  end

  scope "/", ChallengeApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ChallengeApiWeb do
    pipe_through :api

    post "/signin", UserController, :sign_in
    post "/signup", UserController, :create
  end

  scope "/api", ChallengeApiWeb do
    pipe_through [:api, :auth]

    post "/users/:u_id/articles", ArticleController, :create

    post "/events", EventController, :create
    get "/events", EventController, :index
    get "/events/:id", EventController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChallengeApiWeb do
  #   pipe_through :api
  # end
end
