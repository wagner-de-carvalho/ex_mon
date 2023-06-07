defmodule ExMonWeb.PokemonsController do
  use ExMonWeb, :controller
  alias ExMon.Pokemon
  alias ExMonWeb.FallbackController

  action_fallback FallbackController

  def show(conn, %{"name" => name}) do
    with %Pokemon{} = pokemon <- ExMon.fetch_pokemon(name) do
      conn
      |> put_status(:ok)
      |> json(pokemon)
    end
  end
end
