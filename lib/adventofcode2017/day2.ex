defmodule Day2 do
  def checksum(file) do
    {:ok, contents} = File.read(file)
    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&(String.split(&1, ~r{\s+})))
    |> Enum.reduce(0, fn(line, sum) ->
      line = Enum.map(line, &String.to_integer/1)
      sum + Enum.max(line) - Enum.min(line)
    end)
  end
end
