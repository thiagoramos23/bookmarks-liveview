defmodule BookmarksWeb.ErrorHTMLTest do
  use BookmarksWeb.ConnCase, async: true

  # Bring render_to_string/3 for testing custom views
  import Phoenix.Template

  test "renders 404.html" do
    assert render_to_string(BookmarksWeb.ErrorHTML, "404", "html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(BookmarksWeb.ErrorHTML, "500", "html", []) == "Internal Server Error"
  end
end
