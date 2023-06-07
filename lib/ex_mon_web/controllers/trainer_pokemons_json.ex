defmodule ExMonWeb.TrainerPokemonsJSON do
  def create(%{pokemon: pokemon}) do
    %{message: "Pokemon created", pokemon: pokemon}
  end

  def index(%{pokemons: pokemons}) do
    %{message: "Pokemons", pokemons: pokemons}
  end

  def show(%{pokemon: pokemon}) do
    %{message: "Pokemon", pokemon: pokemon}
  end

  def update(%{pokemon: pokemon}) do
    %{message: "Pokemon updated", pokemon: pokemon}
  end
end
