defmodule ExMon.PokeApi.Client do
  use Tesla

  alias Tesla.Env

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def get_pokemon(name) do
    "/pokemon/#{name}"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_get({:ok, %Env{status: 404}}), do: {:error, "Pokemon not found"}
  defp handle_get({:error, _} = error), do: error
end
