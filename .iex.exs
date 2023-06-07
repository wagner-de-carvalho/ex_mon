IO.puts("Carregando ambiente")
alias ExMon.{Repo, Trainer, Trainer.Delete, Trainer.Pokemon}
alias ExMon.Trainer.Pokemon.Create
alias Ecto.UUID
alias ExMon.PokeApi.Client
trainer = %{name: "Ash", password: "senha1234"}

pokemon = %{
  "name" => "pikachu",
  "nickname" => "chuchu",
  "trainer_id" => "29fdbf8f-68f0-4547-bac3-be002c52d5e8",
  "types" => ["eletric"],
  "weight" => 40
}
