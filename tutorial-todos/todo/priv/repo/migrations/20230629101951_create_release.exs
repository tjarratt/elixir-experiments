defmodule Todo.Repo.Migrations.CreateRelease do
  use Ecto.Migration

  def change do
    create table(:release) do
      add :title, :string
      add :date, :string

      timestamps()
    end
  end
end
