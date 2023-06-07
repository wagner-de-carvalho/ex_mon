defmodule ExMon.PokeApi.ClientTest do
  use ExUnit.Case
  import Tesla.Mock

  alias ExMon.PokeApi.Client
  alias Tesla.Env

  @url "https://pokeapi.co/api/v2/pokemon"

  describe "get_pokemon/1" do
    test "when there is a pokemon with the given name, returns the pokemon" do
      body = %{"name" => "charmander", "weight" => 85, "types" => ["fire"]}

      mock(fn %{method: :get, url: "#{@url}/charmander"} ->
        %Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("charmander")
      expected_response = {:ok, body}

      assert expected_response == response
    end

    test "when there is no pokemon with the given name, returns the error" do
      mock(fn %{method: :get, url: "#{@url}/charman"} ->
        %Env{status: 404}
      end)

      response = Client.get_pokemon("charman")
      expected_response = {:error, "Pokemon not found"}

      assert expected_response == response
    end

    test "when there is an unexpected error, returns the error" do
      mock(fn %{method: :get, url: "#{@url}/charman"} ->
        {:error, :timeout}
      end)

      response = Client.get_pokemon("charman")
      expected_response = {:error, :timeout}

      assert expected_response == response
    end
  end
end
