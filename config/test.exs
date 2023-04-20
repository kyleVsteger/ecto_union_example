import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ecto_union_example, EctoUnionExample.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ecto_union_example_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ecto_union_example, EctoUnionExampleWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "d0m2u1AESQCTc51L1f9Chnd7j67Ct/jUrTxPuUlfVdc6kdGLxrsdI0KjJ9VTd/15",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
