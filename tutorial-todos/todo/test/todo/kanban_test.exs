defmodule Todo.KanbanTest do
  use Todo.DataCase

  alias Todo.Kanban

  describe "release" do
    alias Todo.Kanban.Release

    import Todo.KanbanFixtures

    @invalid_attrs %{date: nil, title: nil}

    test "list_release/0 returns all release" do
      release = release_fixture()
      assert Kanban.list_release() == [release]
    end

    test "get_release!/1 returns the release with given id" do
      release = release_fixture()
      assert Kanban.get_release!(release.id) == release
    end

    test "create_release/1 with valid data creates a release" do
      valid_attrs = %{date: "some date", title: "some title"}

      assert {:ok, %Release{} = release} = Kanban.create_release(valid_attrs)
      assert release.date == "some date"
      assert release.title == "some title"
    end

    test "create_release/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Kanban.create_release(@invalid_attrs)
    end

    test "update_release/2 with valid data updates the release" do
      release = release_fixture()
      update_attrs = %{date: "some updated date", title: "some updated title"}

      assert {:ok, %Release{} = release} = Kanban.update_release(release, update_attrs)
      assert release.date == "some updated date"
      assert release.title == "some updated title"
    end

    test "update_release/2 with invalid data returns error changeset" do
      release = release_fixture()
      assert {:error, %Ecto.Changeset{}} = Kanban.update_release(release, @invalid_attrs)
      assert release == Kanban.get_release!(release.id)
    end

    test "delete_release/1 deletes the release" do
      release = release_fixture()
      assert {:ok, %Release{}} = Kanban.delete_release(release)
      assert_raise Ecto.NoResultsError, fn -> Kanban.get_release!(release.id) end
    end

    test "change_release/1 returns a release changeset" do
      release = release_fixture()
      assert %Ecto.Changeset{} = Kanban.change_release(release)
    end
  end
end
