defmodule ChallengeApiWeb.Router do
  use ChallengeApiWeb, :router

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

  scope "/", ChallengeApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ChallengeApiWeb do
    pipe_through :api

    get "/users", UserController, :index
    get "/users/:id/show", UserController, :show
    post "/users/create", UserController, :create

    post "/users/:u_id/article", ArticleController, :create
    get "/articles", ArticleController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChallengeApiWeb do
  #   pipe_through :api
  # end
end
