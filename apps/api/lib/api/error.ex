defmodule Api.Error do

  def err(message) do
    case message do
      :bad_request -> "Bad Request"

    end
  end

end
