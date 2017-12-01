defmodule Day1 do
  def sum(string) do
    list = String.graphemes(string)

    {sum, last} = Enum.reduce(list, {0, nil}, fn(next, {sum, last_char}) ->
      if last_char do
        if last_char == next do
          {sum + String.to_integer(last_char), next}
        else
          {sum, next}
        end
      else
        {sum, next}
      end
    end)

    if last == hd(list) do
      sum + String.to_integer(last)
    else
      sum
    end
  end

  def sum_circle(string) do
    list = String.graphemes(string)
    length = length(list)
    halfway = length(list) / 2

    Enum.with_index(list)
    |> Enum.reduce(0, fn({next, index}, sum) ->
      halfway_around = Enum.at(list, rem(round(index + halfway), length))
      if halfway_around == next do
        sum + String.to_integer(next)
      else
        sum
      end
    end)
  end
end
