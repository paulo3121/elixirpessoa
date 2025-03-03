defmodule Elixirpessoa.Endpoint do
  use Plug.Router
  alias Elixirpessoa.Fetchers.{Poesia}

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/poesia" do
    {:ok, poesia} = Scrap.getPoesia()
    IO.inspect(poesia)
    send_resp(conn, 200, Poison.encode!(poesia))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
