defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias ExMon.Trainer.Pokemon

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields ~w/name password/a
  @required ~w/name password/a

  @derive {Jason.Encoder, only: [:id, :name, :inserted_at, :updated_at, :password_hash]}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many(:pokemon, Pokemon)
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
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
