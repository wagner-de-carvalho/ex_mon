defmodule ExMonWeb.TrainersJSON do
  def create(%{trainer: trainer, token: token}) do
    %{message: "Trainer created", trainer: trainer, token: token}
  end

  def show(%{trainer: trainer}) do
    %{message: "Trainer", trainer: trainer}
  end

  def sign_in(%{token: token}) do
    %{token: token}
  end

  def update(%{trainer: trainer}) do
    %{message: "Trainer updated", trainer: trainer}
  end
end
