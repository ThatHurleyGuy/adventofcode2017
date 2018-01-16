defmodule Day17 do
  def spinlock(step_count, iterations, value_after) do
    list = Enum.reduce(2..iterations, [1, 0], fn(next, list) ->
      step = rem(step_count, length(list))
      {first, second} = Enum.split(list, step + 1)
      [next | second ++ first]
    end)
    index = Enum.find_index(list, &(&1 == value_after))
    Enum.at(list, index + 1)
  end

  def part2(step_count, iterations, value_after) do
    1..iterations
    |> Stream.transform(0, fn(index, new_position) ->
      spin_count = rem(step_count, index)
      next_value = rem(new_position + spin_count, index) + 1
      {[{next_value, index}], next_value}
    end)
    |> Stream.filter(&(elem(&1, 0) == value_after + 1))
    |> Enum.to_list
    |> List.last
    |> elem(1)
  end
end
