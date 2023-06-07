defmodule ExMon.Trainer.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.Trainer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~w/name nickname trainer_id types weight/a
  @required @fields

  @derive {Jason.Encoder, only: [:id, :name, :nickname, :trainer, :types, :weight]}

  schema "pokemons" do
    field :name, :string
    field :nickname, :string
    field :weight, :integer
    field :types, {:array, :string}

    belongs_to(:trainer, Trainer)

    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params \\ %{}) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(trainer, params) do
    trainer
    |> cast(params, @fields)
    |> validate_required(@required)
    # |> assoc_constraint(:trainer) # Verificar se treinador existe
    |> validate_length(:nickname, min: 2)
  end

  def update_changeset(pokemon, params) do
    pokemon
    |> cast(params, [:nickname])
    |> validate_required([:nickname], min: 2)
  end
end
