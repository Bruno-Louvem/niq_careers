defmodule Careers.Test.Support do

    defmacro __using__(_) do
        quote do
            use ExUnit.Case
            alias FakerElixir, as: Faker
            alias Careers.Test
            alias Careers.{
                Exams
            }
        end
    end
end
