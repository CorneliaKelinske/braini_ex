defmodule BrainiEx.WordGames.Wordle.Words do
  @moduledoc """
  Pulls in wordle words from a github repo
  """
  @url "https://raw.githubusercontent.com/tabatkins/wordle-list/main/words"
  @defaults_opts [
    sandbox?: Mix.env() === :test
  ]

  @spec get_words(keyword()) :: {:ok, [String.t()]} | {:error, ErrorMessage.t()}
  def get_words(opts \\ []) do
    opts = Keyword.merge(@defaults_opts, opts)

    if opts[:sandbox?] do
      sandbox_get_response(@url, "", opts)
    else
      live_get_response(@url)
    end
  end

  defp live_get_response(url) do
    case Req.get!(url) do
      %Req.Response{status: 200, body: body} ->
        {:ok, String.split(body, "\n")}

      error ->
        {:error, ErrorMessage.bad_request("Unable to request wordle words", inspect(error))}
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
