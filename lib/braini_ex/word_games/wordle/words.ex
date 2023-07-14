defmodule BrainiEx.WordGames.Wordle.Words do
  @moduledoc """
  Pulls in wordle words from a github repo
  """
  @url "https://raw.githubusercontent.com/tabatkins/wordle-list/main/words"
  @defaults_opts [
    sandbox?: Mix.env() === :test
  ]

  @spec get_words(keyword()) :: [String.t()]
  def get_words(opts \\ []) do
    opts = Keyword.merge(@defaults_opts, opts)

    if opts[:sandbox?] do
      sandbox_get_response(@url, "", opts)
    else
      @url
      |> Req.get!()
      |> Map.get(:body)
      |> String.split("\n")
    end
  end

  if Mix.env() === :test do
    defdelegate sandbox_get_response(url, query, opts),
      to: BrainiEx.Support.HTTPSandbox,
      as: :get_response
  else
    defp sandbox_get_response(url, _, _) do
      raise """
      Cannot use HTTPSandbox outside of test
      url requested: #{inspect(url)}
      """
    end
  end
end
