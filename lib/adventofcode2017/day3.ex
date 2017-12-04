defmodule Day3 do
  def shortest_path(index) do
    {:ok, {x, y}} =
      0
      |> Stream.iterate(&(&1 + 1))
      |> Stream.flat_map(&build_level/1)
      |> Stream.scan({0,0}, fn({step_x, step_y}, {current_x, current_y}) ->
        next = {step_x + current_x, step_y + current_y}
        next
      end)
      |> Enum.fetch(index-1)

    abs(x) + abs(y)
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
end
