defmodule Api.Helpers do

  def extract_changeset_data(changeset) do
      if changeset.valid?() do
          {:ok, Params.data(changeset)}
      else
          {:error, %{error: "Invalid Changeset"}}
      end
  end

  defimpl Poison.Encoder, for: Tuple do
    def encode(tuple, options) do
      tuple
      |> Tuple.to_list
      |> Poison.encode!
    end
  end

end
