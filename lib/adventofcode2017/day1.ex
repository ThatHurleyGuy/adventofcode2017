defmodule Day1 do
  def sum(string) do
    list = String.graphemes(string)

    sum(list, 1)
  end

  def sum_circle(string) do
    list = String.graphemes(string)
    halfway = round(length(list) / 2)

    sum(list, halfway)
  end

  def sum(list, distance) do
    {first_part, second_part} = Enum.split(list, distance)
    rotated = second_part ++ first_part

    Enum.zip(list, rotated)
    |> Enum.reduce(0, fn({current, halfway_around}, sum) ->
      if halfway_around == current do
        sum + String.to_integer(current)
      else
        sum
      end
    end)
  end
end
