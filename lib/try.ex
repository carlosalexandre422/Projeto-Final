defmodule Try do
  def get(url) do
    HTTPoison.get(url)
    |> process_response
    |> process_result
  end

  def get_random_pokemon() do
    base_url = "https://pokeapi.co/api/v2/pokemon/"
    random_id = Integer.to_string(:rand.uniform(151))

    get(base_url <> random_id)
  end

  defp process_response({:error, r}), do: {:error, r}

  defp process_response({:ok, %HTTPoison.Response{status_code: 200, body: b}}) do
    {:ok, b}
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: _, body: b}}) do
    {:error, b}
  end

  defp process_result({:error, _}) do
    IO.puts("Erro na requisição")
  end

  defp process_result({:ok, json}) do
    {:ok, data} = Poison.decode(json)
    data
  end
end
