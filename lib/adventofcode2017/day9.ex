defmodule Day9 do
  def groups(file) do
		{:ok, contents} = File.read(file)
		String.trim(contents)
    |> String.graphemes
    |> count_groups
  end

  def count_groups(rest, contained \\ 0)
  def count_groups(["{" | rest], contained), do: count_groups(rest, contained + 1)
  def count_groups(["}", "," | rest], contained), do: contained + count_groups(rest, contained - 1)
  def count_groups(["}" | rest], contained), do: contained + count_groups(rest, contained-1)
  def count_groups(["<" | rest], contained), do: remove_garbage(rest, contained)
  def count_groups(["," | rest], contained), do: count_groups(rest, contained)
  def count_groups([], _), do: 0

  def remove_garbage([">" | rest], contained),do: count_groups(rest, contained)
  def remove_garbage(["!", _ | rest], contained), do: remove_garbage(rest, contained)
  def remove_garbage([_ | rest], contained), do: remove_garbage(rest, contained)
end
