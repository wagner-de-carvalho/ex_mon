defmodule ExMonWeb.FallbackController do
  use Phoenix.Controller

  alias ExMonWeb.ErrorJSON

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: ErrorJSON)
    |> render(:error, error: :unauthorized)
  end

  def call(conn, {:error, result}) when is_bitstring(result) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, error: result)
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, error: result)
  end
end
