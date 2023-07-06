defmodule PhoenixTestingWeb.ErrorJSONTest do
  use PhoenixTestingWeb.ConnCase, async: true

  @moduletag :error_view_case

  test "renders 404" do
    assert PhoenixTestingWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert PhoenixTestingWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
