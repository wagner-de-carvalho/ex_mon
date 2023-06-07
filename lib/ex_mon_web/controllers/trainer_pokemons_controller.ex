defmodule ExMonWeb.TrainerPokemonsController do
  use ExMonWeb, :controller
  alias ExMon.Trainer.Pokemon
  alias ExMonWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, pokemon} <- ExMon.create_trainer_pokemon(params) do
      conn
      |> put_status(:created)
      |> render(:create, pokemon: pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _pokemon} <- ExMon.delete_trainer_pokemon(id) do
      conn
      |> send_resp(:no_content, "")
    end
  end

  def index(conn, _params) do
    with pokemons <- ExMon.get_all_trainer_pokemon() do
      conn
      |> put_status(:ok)
      |> render(:index, pokemons: pokemons)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, pokemon} <- ExMon.get_trainer_pokemon(id) do
      conn
      |> put_status(:ok)
      |> render(:show, pokemon: pokemon)
    end
  end

  def update(conn, params) do
    with %Pokemon{} = pokemon <- ExMon.update_trainer_pokemon(params) do
      conn
      |> put_status(:ok)
      |> render(:update, pokemon: pokemon)
    end
  end
end
