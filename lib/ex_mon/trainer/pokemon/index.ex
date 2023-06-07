defmodule ExMon.Trainer.Pokemon.Index do
  alias ExMon.{Repo, Trainer.Pokemon}

  def call, do: Repo.all(Pokemon)
end
