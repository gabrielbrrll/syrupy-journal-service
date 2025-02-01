defmodule SyrupyApi.Repo do
  use Ecto.Repo,
    otp_app: :syrupy_api,
    adapter: Ecto.Adapters.Postgres
end
