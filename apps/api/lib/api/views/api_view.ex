defmodule Api.ApiView do
    use Api, :view

    def render("index.json", _assigns) do
        %{status: "OK"}
    end
end
