defmodule Day9 do
  def groups(file) do
    parse_file(file)
    |> count_groups
  end

  def garbage(file) do
    parse_file(file)
    |> count_garbage
  end

  defp parse_file(file) do
		{:ok, contents} = File.read(file)
		String.trim(contents)
    |> String.graphemes
  end

  defp count_groups(rest, contained \\ 0)
  defp count_groups(["{" | rest], contained), do: count_groups(rest, contained + 1)
  defp count_groups(["}", "," | rest], contained), do: contained + count_groups(rest, contained - 1)
  defp count_groups(["}" | rest], contained), do: contained + count_groups(rest, contained-1)
  defp count_groups(["<" | rest], contained), do: remove_garbage(rest, contained)
  defp count_groups(["," | rest], contained), do: count_groups(rest, contained)
  defp count_groups([], _), do: 0

  defp remove_garbage([">" | rest], contained),do: count_groups(rest, contained)
  defp remove_garbage(["!", _ | rest], contained), do: remove_garbage(rest, contained)
  defp remove_garbage([_ | rest], contained), do: remove_garbage(rest, contained)

  defp count_garbage(rest, contained \\ 0)
  defp count_garbage(["<" | rest], contained), do: count_inner_garbage(rest, contained)
  defp count_garbage([_ | rest], contained), do: count_garbage(rest, contained)
  defp count_garbage([], contained), do: contained

  defp count_inner_garbage([">" | rest], contained),do: count_garbage(rest, contained)
  defp count_inner_garbage(["!", _ | rest], contained), do: count_inner_garbage(rest, contained)
  defp count_inner_garbage([_ | rest], contained), do: count_inner_garbage(rest, contained + 1)
end
