defmodule Api.ErrorView do
  use Api, :view

  def render("404.json", _assigns) do
    handle_error("Page not found")
  end

  def render("500.json", _assigns) do
    handle_error("Invalid Request")
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end

  defp handle_error(assings) do
    %{error: assings}
  end
end
