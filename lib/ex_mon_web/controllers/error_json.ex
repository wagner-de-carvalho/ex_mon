defmodule ExMonWeb.ErrorJSON do
  import Ecto.Changeset, only: [traverse_errors: 2]
  alias Ecto.Changeset

  def error(%{error: %Changeset{} = error}) do
    %{errors: translate_errors(error)}
  end

  def error(%{error: error_message}) do
    %{error: error_message}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
