defmodule Server1.Repo.Migrations.CreateFrutas do
  use Ecto.Migration

  def change do
    create table(:fruta) do
      add :nombre, :string
      add :detalles, :string

      timestamps()
    end
    create unique_index(:fruta, [:nombre])

  end
end
