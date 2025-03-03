defmodule Scrap do
  def getPoesia do
    id = :rand.uniform(4544)
    IO.puts(id)

    {:ok, document} =
      Req.get!("http://arquivopessoa.net/textos/#{id}")
      |> Map.get(:body)
      |> Floki.parse_document()

    [{_div, _class, [autor]}] = Floki.find(document, "div.autor")
    [{_h1, _class, [titulo]}] = Floki.find(document, "h1.titulo-texto")
    found = Floki.find(document, "div.texto-poesia")
    case found do
      [] -> getPoesia()
      [{_div, _class, children}] ->
	linhas = Enum.map(children, fn
	{_s, _, []} -> "\n"
	{_s, _, [linha]} -> linha <> "\n"
      end)
	poesia = "#{autor}\n\n#{id}: #{titulo}\n#{linhas}"
    end
  end
end
