defmodule Day10 do
  use Bitwise

  def full_hash(input_string) do
    lengths = to_charlist(input_string) ++ [17, 31, 73, 47, 23]
    hash(lengths, 64)
    |> Enum.chunk(16)
    |> Enum.map(fn(chunk) ->
      Enum.reduce(chunk, fn(next, curr) ->
        next ^^^ curr
      end)
      |> :binary.encode_unsigned |> Base.encode16
    end)
    |> Enum.join
    |> String.downcase
  end

  def first_multiple(input) do
    [x, y | _] = hash(input)
    x * y
  end

  def hash(input, rounds \\ 1) do
    list = Enum.to_list(0..255)
    input_length = length(input)

    indexed_lengths = Enum.with_index(input)
    hash = Enum.reduce(0..(rounds-1), list, fn(round, list) ->
      Enum.reduce(indexed_lengths, list, fn({length, skip_size}, list) ->
        rotate(list, length, skip_size, round * input_length)
      end)
    end)

    n = (length(input) * rounds - 1)
    indices = Enum.sum(input) * rounds
    total_skip = round(indices + (((n*n + n) / 2)))
    skip = rem(total_skip, 256)
    {rest, beginning} = Enum.split(hash, 256 - skip)
    beginning ++ rest
  end

  defp rotate(list, length, skip_size, base_skip) do
    {to_reverse, rest} = Enum.split(list, length)
    reversed = Enum.reverse(to_reverse)
    list = reversed ++ rest
    {to_end, beginning} = Enum.split(list, rem(length + skip_size + base_skip, length(list)))
    beginning ++ to_end
  end
end
