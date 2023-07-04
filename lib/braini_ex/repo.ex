defmodule BrainiEx.Repo do
  use Ecto.Repo,
    otp_app: :braini_ex,
    adapter: Ecto.Adapters.Postgres
end
