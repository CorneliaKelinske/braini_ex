defmodule BrainiEx.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :braini_ex,
    adapter: Ecto.Adapters.Postgres
end
