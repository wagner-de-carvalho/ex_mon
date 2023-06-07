defmodule ExMonWeb.TrainersControllerTest do
  use ExMonWeb.ConnCase
  import ExMonWeb.Auth.Guardian
  alias ExMon.Trainer

  describe "show/2" do
    setup %{conn: conn} do
      params = %{name: "Apolo", password: "pwd123"}
      {:ok, trainer} = ExMon.create_trainer(params)
      {:ok, token, _} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "Apolo", password: "123456"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      response =
        conn
        |> get("/api/trainers/#{id}")
        |> json_response(:ok)

      assert %{"trainer" => %{"id" => ^id}} = response
    end

    test "when there is invalid id, returns an error", %{conn: conn} do
      id = "123"

      response =
        conn
        |> get("/api/trainers/#{id}")
        |> json_response(:not_found)

      assert %{"error" => _mesage} = response
    end
  end
end
