defmodule ExMon.Trainer.Pokemon.Get do
  alias Ecto.UUID
  alias ExMon.{Repo, Trainer.Pokemon}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, "Pokemon not found"}
      pokemon -> {:ok, Repo.preload(pokemon, :trainer)}
    end
  end
end
