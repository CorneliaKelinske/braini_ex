defmodule BrainiEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Start the Telemetry supervisor
        BrainiExWeb.Telemetry,
        # Start the Ecto repository
        BrainiEx.Repo,
        # Start the PubSub system
        {Phoenix.PubSub, name: BrainiEx.PubSub},
        # Start Finch
        {Finch, name: BrainiEx.Finch},
        # Start the Endpoint (http/https)
        BrainiExWeb.Endpoint
        # Start a worker by calling: BrainiEx.Worker.start_link(arg)
      ] ++ random_word_generator()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BrainiEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  if Mix.env() === :test do
    def random_word_generator, do: []
  else
    def random_word_generator, do: [{BrainiEx.WordGames.Wordle.RandomWordGenerator, []}]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BrainiExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
