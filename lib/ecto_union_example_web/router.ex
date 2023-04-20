defmodule EctoUnionExampleWeb.Router do
  use EctoUnionExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EctoUnionExampleWeb do
    pipe_through :api
  end
end
