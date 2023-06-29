defmodule TodoWeb.ReleaseController do
  use TodoWeb, :controller

  alias Todo.Kanban
  alias Todo.Kanban.Release

  def index(conn, _params) do
    release = Kanban.list_release()
    render(conn, :index, release_collection: release)
  end

  def new(conn, _params) do
    changeset = Kanban.change_release(%Release{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"release" => release_params}) do
    case Kanban.create_release(release_params) do
      {:ok, release} ->
        conn
        |> put_flash(:info, "Release created successfully.")
        |> redirect(to: ~p"/release/#{release}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    release = Kanban.get_release!(id)
    render(conn, :show, release: release)
  end

  def edit(conn, %{"id" => id}) do
    release = Kanban.get_release!(id)
    changeset = Kanban.change_release(release)
    render(conn, :edit, release: release, changeset: changeset)
  end

  def update(conn, %{"id" => id, "release" => release_params}) do
    release = Kanban.get_release!(id)

    case Kanban.update_release(release, release_params) do
      {:ok, release} ->
        conn
        |> put_flash(:info, "Release updated successfully.")
        |> redirect(to: ~p"/release/#{release}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, release: release, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    release = Kanban.get_release!(id)
    {:ok, _release} = Kanban.delete_release(release)

    conn
    |> put_flash(:info, "Release deleted successfully.")
    |> redirect(to: ~p"/release")
  end
end
