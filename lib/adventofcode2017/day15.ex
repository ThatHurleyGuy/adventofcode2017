defmodule Day15 do
  use Bitwise

  def judge(a_start, a_multiple, b_start, b_multiple, max) do
    stream(a_start, 16807, a_multiple)
    |> Stream.zip(stream(b_start, 48271, b_multiple))
    |> Stream.take(max)
    |> Stream.filter(fn({a, b}) ->
      (a &&& 0xffff) == (b &&& 0xffff)
    end)
    |> Enum.to_list
    |> length
  end

  defp stream(start, factor, multiple) do
    start
    |> Stream.iterate(&(next_value(&1, factor, multiple)))
  end

  defp next_value(start, factor, multiple) do
    next = rem(start * factor, 2147483647)
    if rem(next, multiple) == 0 do
      next
    else
      next_value(next, factor, multiple)
    end
  end
end
