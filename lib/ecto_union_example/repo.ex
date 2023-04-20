defmodule EctoUnionExample.Repo do
  use Ecto.Repo,
    otp_app: :ecto_union_example,
    adapter: Ecto.Adapters.Postgres
end
