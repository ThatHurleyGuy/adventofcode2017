defmodule Day21 do
  def process(file) do
    {:ok, contents} = File.read(file)

    rules = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{}, fn(string, rules) ->
      [from, to] = String.split(string, " => ")

      from = String.split(from, "/")
      |> Enum.map(&String.graphemes/1)
      from_combos = rotations(from)

      to = String.split(to, "/")
      |> Enum.map(&String.graphemes/1)

      Enum.reduce(from_combos, rules, fn(from, rules) -> Map.put(rules, from, to) end)
    end)

    initial = [[".","#","."],[".",".","#"],["#","#","#"]]

    puzzle = Enum.reduce(1..18, initial, fn(_, puzzle) ->
      tick(puzzle, rules)
    end)

    List.flatten(puzzle)
    |> Enum.count(&(&1 == "#"))
  end

  defp apply_rule(puzzle, rules) do
    rules[puzzle]
  end

  defp tick(puzzle, rules) do
    if length(Enum.flat_map(puzzle, &(&1))) < 12 do
      apply_rule(puzzle, rules)
    else
      split_puzzle(puzzle, rules)
    end
  end

  defp split_puzzle(input, rules) do
    # This needs to split based on if it's divisible by 2 or 3
    divisor = if length(input) |> rem(2) == 0, do: 2, else: 3

    Enum.chunk_every(input, divisor)
    |> Enum.flat_map(fn(group) ->
      Enum.map(group, &Enum.chunk_every(&1, divisor))
      |> Enum.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&apply_rule(&1, rules))
      |> Enum.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.concat/1)
    end)
  end

  defp rotations(input) do
    zipped = Enum.zip(input) |> Enum.map(&Tuple.to_list/1)
    [
      input,
      Enum.reverse(input),
      Enum.map(input, &Enum.reverse/1),
      Enum.map(input, &Enum.reverse/1) |> Enum.reverse,
      zipped,
      Enum.reverse(zipped),
      Enum.map(zipped, &Enum.reverse/1),
      Enum.map(zipped, &Enum.reverse/1) |> Enum.reverse,
    ]
  end
end
