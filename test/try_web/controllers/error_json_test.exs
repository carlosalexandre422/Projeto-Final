defmodule TryWeb.ErrorJSONTest do
  use TryWeb.ConnCase, async: true

  test "renders 404" do
    assert TryWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert TryWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
