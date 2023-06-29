defmodule Todo.KanbanFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todo.Kanban` context.
  """

  @doc """
  Generate a release.
  """
  def release_fixture(attrs \\ %{}) do
    {:ok, release} =
      attrs
      |> Enum.into(%{
        date: "some date",
        title: "some title"
      })
      |> Todo.Kanban.create_release()

    release
  end
end
