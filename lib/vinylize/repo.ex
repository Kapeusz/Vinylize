defmodule Vinylize.Repo do
  use Ecto.Repo,
    otp_app: :vinylize,
    adapter: Ecto.Adapters.Postgres
end
