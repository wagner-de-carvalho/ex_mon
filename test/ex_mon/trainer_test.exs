defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias Ecto.Changeset
  alias ExMon.Trainer

  setup do
    params = %{name: "Apolo", password: "123654"}
    error_params = %{name: "Apolo", password: "123"}

    %{params: params, error_params: error_params}
  end

  describe "changeset/1" do
    test "when all params are valid returns a changeset", %{params: params} do
      response = Trainer.changeset(params)

      assert %Changeset{
               action: nil,
               changes: %{
                 name: "Apolo",
                 password: "123654"
               },
               errors: [],
               data: %Trainer{},
               valid?: true
             } = response
    end

    test "when there are invalid params returns an error", %{error_params: params} do
      response = Trainer.changeset(params)

      assert %{valid?: false} = response
      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end
  end

  describe "build/1" do
    test "when all params are valid returns a trainer struct", %{params: params} do
      response = Trainer.build(params)
      name = params.name
      password = params.password

      assert {:ok, %Trainer{name: ^name, password: ^password}} = response
    end

    test "when some params are invalid an error tuple", %{error_params: params} do
      response = Trainer.build(params)
      assert {:error, _error} = response

      assert elem(response, 1) |> errors_on() == %{
               password: ["should be at least 6 character(s)"]
             }
    end
  end
end
