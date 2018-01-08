defmodule Day14 do
  use Bitwise

  def count_regions(input) do
    grid = build_grid(input)
    regions = DisjointSet.new
    Enum.reduce(0..127, regions, fn(x, regions) ->
      Enum.reduce(0..127, regions, fn(y, regions) ->
        value = Enum.at(Enum.at(grid, y), x)
        if value == 1 do
          regions = DisjointSet.add_new(regions, {x, y})
          Enum.reduce(neighbors(x, y), regions, fn({nx, ny}, regions) ->
            neighbor_value = Enum.at(Enum.at(grid, ny), nx)
            if neighbor_value == 1 do
              regions = DisjointSet.add_new(regions, {nx, ny})
              DisjointSet.union(regions, {x,y}, {nx, ny})
            else
              regions
            end
          end)
        else
          regions
        end
      end)
    end)
    |> Enum.filter(fn({node, {parent, _}}) ->
      node == parent
    end)
    |> length
  end

  def count_used(input) do
    build_grid(input)
    |> List.flatten
    |> Enum.filter(&(&1 == 1))
    |> length
  end

  defp build_grid(input) do
    Enum.map(0..127, fn(row) ->
      "#{input}-#{row}"
      |> Day10.full_hash
      |> String.graphemes
      |> Enum.flat_map(fn(n) ->
        number = hexdigit(n)
        [(number &&& 0b1000) >>> 3, (number &&& 0b100) >>> 2, (number &&& 0b10) >>> 1, number &&& 0b1]
      end)
    end)
  end

  defp neighbors(x, y) do
    [
      {x+1,y},
      {x-1,y},
      {x,y+1},
      {x,y-1},
    ]
    |> Enum.filter(fn({x,y}) ->
      x >= 0 && y >= 0 && x < 128 && y < 128
    end)
  end

  defp hexdigit(char) do
    case char do
      "a" -> 10
      "b" -> 11
      "c" -> 12
      "d" -> 13
      "e" -> 14
      "f" -> 15
      _ -> String.to_integer(char)
    end
  end
end
