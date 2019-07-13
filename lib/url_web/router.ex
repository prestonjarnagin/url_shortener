defmodule UrlWeb.Router do
  use UrlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UrlWeb do
    pipe_through :api

    resources "/urls", URLController, only: [:create, :show, :delete]
    get "/redirect/:short_url", URLController, :short_url_redirect
  end
end
