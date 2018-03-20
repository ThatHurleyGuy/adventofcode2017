defmodule Day3 do
  def shortest_path(index) do
    {:ok, {{x, y}, map}} =
      0
      |> Stream.iterate(&(&1 + 1))
      |> Stream.flat_map(&build_level/1)
      |> Stream.scan({{0,0}, %{}}, fn({step_x, step_y}, {{current_x, current_y}, map}) ->
        next = {step_x + current_x, step_y + current_y}
        next_value = neighbors(next)
        |> Enum.map(fn({x,y}) -> map[{x,y}] || 0 end)
        |> Enum.sum

        next_value = if next_value == 0 do
          IO.inspect 1
        else
          next_value
        end
        map = Map.put(map, next, next_value)
        {next, map}
      end)
      |> Enum.fetch(index-1)

    part2 = Enum.map(map, fn({_, value}) ->
      value
    end)
    |> Enum.sort
    |> IO.inspect
    |> Enum.find(0, fn(value) -> value > index end)

    {abs(x) + abs(y), part2}
  end

  def build_level(0), do: [{0,0}]

  def build_level(level) do
    size = level*2
    [{1,0}] ++
      Enum.map(2..size, fn _ -> {0, 1} end) ++
      Enum.map(1..size, fn _ -> {-1, 0} end) ++
      Enum.map(1..size, fn _ -> {0, -1} end) ++
      Enum.map(1..size, fn _ -> {1, 0} end)
  end

  defp neighbors({x, y}) do
    [
      {x+1, y},
      {x+1, y+1},
      {x+1, y-1},
      {x-1, y},
      {x-1, y-1},
      {x-1, y+1},
      {x, y+1},
      {x, y-1},
    ]
  end
end
