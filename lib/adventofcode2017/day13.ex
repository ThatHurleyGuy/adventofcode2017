defmodule Day13 do
  def severity(file) do
    {:ok, contents} = File.read(file)
    scanners = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, ": ")))
    |> Enum.reduce(%{}, fn([depth, range], scanners) ->
      Map.put(scanners, String.to_integer(depth), String.to_integer(range))
    end)

    count_severity(scanners)
  end

  defp count_severity(scanners) do
    Enum.map(scanners, fn({depth, range}) ->
      if depth == 0 || rem(depth, (range-1)*2) == 0 do
        range * depth
      else
        0
      end
    end)
    |> Enum.sum
  end
end
