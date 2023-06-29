defmodule TodoWeb.ReleaseControllerTest do
  use TodoWeb.ConnCase

  import Todo.KanbanFixtures

  @create_attrs %{date: "some date", title: "some title"}
  @update_attrs %{date: "some updated date", title: "some updated title"}
  @invalid_attrs %{date: nil, title: nil}

  describe "index" do
    test "lists all release", %{conn: conn} do
      conn = get(conn, ~p"/release")
      assert html_response(conn, 200) =~ "Listing Release"
    end
  end

  describe "new release" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/release/new")
      assert html_response(conn, 200) =~ "New Release"
    end
  end

  describe "create release" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/release", release: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/release/#{id}"

      conn = get(conn, ~p"/release/#{id}")
      assert html_response(conn, 200) =~ "Release #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/release", release: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Release"
    end
  end

  describe "edit release" do
    setup [:create_release]

    test "renders form for editing chosen release", %{conn: conn, release: release} do
      conn = get(conn, ~p"/release/#{release}/edit")
      assert html_response(conn, 200) =~ "Edit Release"
    end
  end

  describe "update release" do
    setup [:create_release]

    test "redirects when data is valid", %{conn: conn, release: release} do
      conn = put(conn, ~p"/release/#{release}", release: @update_attrs)
      assert redirected_to(conn) == ~p"/release/#{release}"

      conn = get(conn, ~p"/release/#{release}")
      assert html_response(conn, 200) =~ "some updated date"
    end

    test "renders errors when data is invalid", %{conn: conn, release: release} do
      conn = put(conn, ~p"/release/#{release}", release: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Release"
    end
  end

  describe "delete release" do
    setup [:create_release]

    test "deletes chosen release", %{conn: conn, release: release} do
      conn = delete(conn, ~p"/release/#{release}")
      assert redirected_to(conn) == ~p"/release"

      assert_error_sent 404, fn ->
        get(conn, ~p"/release/#{release}")
      end
    end
  end

  defp create_release(_) do
    release = release_fixture()
    %{release: release}
  end
end
