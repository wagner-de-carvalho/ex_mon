defmodule ExMon.Trainer.CreateTest do
  use ExMon.DataCase
  alias Ecto.Changeset
  alias ExMon.{Repo, Trainer}
  alias Trainer.Create

  setup do
    params = %{name: "Apolo", password: "123456"}
    error_params = %{name: "Apolo"}

    %{params: params, error_params: error_params}
  end

  describe "call/1" do
    test "when all params are valid, creates a trainer", %{params: params} do
      count_before = Repo.aggregate(Trainer, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{}} = response
      assert count_after > count_before
    end

    test "when there are invalid params, returns an error", %{error_params: params} do
      response = Create.call(params)

      assert {:error, %Changeset{valid?: false}} = response
      assert elem(response, 1) |> errors_on() == %{password: ["can't be blank"]}
    end
  end
end
