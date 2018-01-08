defmodule Day14 do
  use Bitwise

  def count_used(input) do
    Enum.map(0..127, fn(row) ->
      "#{input}-#{row}"
      |> Day10.full_hash
      |> String.graphemes
      |> Enum.flat_map(fn(n) ->
        number = hexdigit(n)
        [(number &&& 0b1000) >>> 3, (number &&& 0b100) >>> 2, (number &&& 0b10) >>> 1, number &&& 0b1]
      end)
    end)
    |> List.flatten
    |> Enum.filter(&(&1 == 1))
    |> length
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
