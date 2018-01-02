defmodule Day11 do
  def distance(file) do
    {:ok, contents} = File.read(file)

    String.trim(contents)
    |> String.split(",")
    |> Enum.reduce({0,0,0}, fn(direction, {x,y,z}) ->
      {x1,y1,z1} = coord(direction)
      {x + x1, y + y1, z + z1}
    end)
    |> Tuple.to_list
    |> Enum.map(&abs/1)
    |> Enum.max
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
