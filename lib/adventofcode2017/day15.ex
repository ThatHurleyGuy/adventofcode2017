defmodule Day15 do
  use Bitwise

  def judge(a_start, b_start) do
    {list, _} = Enum.map_reduce(0..40000000, {a_start, b_start}, fn(_index, {previous_a, previous_b}) ->
      next_a = rem(previous_a * 16807, 2147483647)
      next_b = rem(previous_b * 48271, 2147483647)
      match = (next_a &&& 0xffff) == (next_b &&& 0xffff)
      {match, {next_a, next_b}}
    end)
    Enum.filter(list, &(&1))
    |> length
  end
end
