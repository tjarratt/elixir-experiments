defmodule PhoenixTesting.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_testing,
    adapter: Ecto.Adapters.Postgres
end
