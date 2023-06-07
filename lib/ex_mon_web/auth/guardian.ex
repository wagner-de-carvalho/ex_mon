defmodule ExMonWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_mon

  alias ExMon.{Repo, Trainer}

  def subject_for_token(trainer, _claims) do
    trainer.id
    |> to_string()
    |> then(fn sub -> {:ok, sub} end)
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExMon.fetch_trainer()
  end

  def authenticate(%{"id" => trainer_id, "password" => password}) do
    case Repo.get(Trainer, trainer_id) do
      nil -> {:error, "Trainer not found"}
      %Trainer{} = trainer -> validate_password(trainer, password)
    end
  end

  defp validate_password(%Trainer{password_hash: hash} = trainer, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(trainer) do
    trainer
    |> encode_and_sign()
    |> then(fn {:ok, token, _} -> {:ok, token} end)
  end
end
