defmodule Api.ErrorViewTest do
  use Api.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
      assert render_to_string(Api.ErrorView, "404.json", []) ==
    "{\"error\":\"Page not found\"}"
  end

  test "render 500.json" do
    assert render_to_string(Api.ErrorView, "500.json", []) ==
           "{\"error\":\"Invalid Request\"}"
  end

  test "render any other" do
    assert render_to_string(Api.ErrorView, "505.json", []) ==
    "{\"error\":\"Invalid Request\"}"
  end
end
