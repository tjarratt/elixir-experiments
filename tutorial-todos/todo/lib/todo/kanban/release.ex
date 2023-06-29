defmodule Todo.Kanban.Release do
  use Ecto.Schema
  import Ecto.Changeset

  schema "release" do
    field :date, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(release, attrs) do
    release
    |> cast(attrs, [:title, :date])
    |> validate_required([:title, :date])
  end
end
