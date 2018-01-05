defmodule Day10 do
  def hash(input) do
    list = Enum.to_list(0..255)
    hash = Enum.with_index(input)
    |> Enum.reduce(list, fn({length, skip_size}, list) ->
      rotate(list, length, skip_size)
    end)

    n = length(input) - 1
    indices = Enum.reduce(input, 0, &((&1) + &2))
    total_skip = round(indices + ((n*n + n) / 2))
    skip = rem(total_skip, 256)
    Enum.at(hash, 256 - skip) * Enum.at(hash, 256 - skip + 1)
  end

  defp rotate(list, length, skip_size) do
    {to_reverse, rest} = Enum.split(list, length)
    reversed = Enum.reverse(to_reverse)
    list = reversed ++ rest
    {to_end, beginning} = Enum.split(list, rem(length + skip_size, length(list)))
    beginning ++ to_end
  end
end
