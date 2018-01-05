defmodule Api.ApiController do
    use Api, :controller

    def index(conn, _params) do
        render conn, "index.json"
    end
end
