defmodule Day11 do
  def distance(file) do
    {_, final} = build_list(file)
    Tuple.to_list(final)
    |> Enum.map(&abs/1)
    |> Enum.max
  end

  def furthest_distance(file) do
    {history, _} = build_list(file)
    Enum.flat_map(history, &Tuple.to_list/1)
    |> Enum.map(&abs/1)
    |> Enum.max
  end

  defp build_list(file) do
    {:ok, contents} = File.read(file)

    String.trim(contents)
    |> String.split(",")
    |> Enum.map_reduce({0,0,0}, fn(direction, {x,y,z}) ->
      {x1,y1,z1} = coord(direction)
      new_cord = {x + x1, y + y1, z + z1}
      {new_cord, new_cord}
    end)
  end

  defp coord(direction) do
    case direction do
      "n" -> {1,0,-1}
      "s" -> {-1,0,1}
      "ne" -> {1,-1,0}
      "nw" -> {0,1,-1}
      "se" -> {0,-1,1}
      "sw" -> {-1,1,0}
    end
  end
end
