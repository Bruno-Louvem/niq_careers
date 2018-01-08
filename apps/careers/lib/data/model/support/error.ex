defmodule DAL.Profile.Support.Error do
  @moduledoc false
    def err(message) do
      case message do
        :duplicated_email -> "Duplicated e-mail address"
      end
    end
end
