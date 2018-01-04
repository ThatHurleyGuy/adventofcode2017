defmodule Day13 do
  def severity(file) do
    scanners = build_scanners(file)

    count_severity(scanners)
  end

  def find_delay(file) do
    scanners = build_scanners(file)

    {delay, _} = 0
    |> Stream.iterate(&(&1+1))
    |> Stream.map(&({&1, count_severity(scanners, &1)}))
    |> Enum.find(fn({_, severity}) -> severity == 0 end)

    delay
  end

  defp build_scanners(file) do
    {:ok, contents} = File.read(file)
    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, ": ")))
    |> Enum.reduce(%{}, fn([depth, range], scanners) ->
      Map.put(scanners, String.to_integer(depth), String.to_integer(range))
    end)
  end

  defp count_severity(scanners, delay \\ 0) do
    Enum.map(scanners, fn({depth, range}) ->
      if rem(depth + delay, (range-1)*2) == 0 do
        # Adding range is just a dirty hack to give a penalty at depth 0
        range * depth + delay
      else
        0
      end
    end)
    |> Enum.sum
  end
end
