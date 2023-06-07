defmodule ExMon.Repo.Migrations.AddPokemonsTable do
  use Ecto.Migration

  def change do
    create table(:pokemons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :nickname, :string
      add :weight, :integer
      add :types, {:array, :string}

      add :trainer_id, references(:trainers, type: :binary_id, on_delete: :delete_all),
        null: false

      timestamps()
    end
  end
end
