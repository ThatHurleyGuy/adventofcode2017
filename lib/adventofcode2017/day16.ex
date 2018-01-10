defmodule Day16 do
  def dance(file, dance_count \\ 1) do
    {:ok, contents} = File.read(file)
    moves = String.trim(contents)
    |> String.split(",")
    |> Enum.map(&parse_move/1)

    {_, list} = Enum.reduce(1..dance_count, {%{}, ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]}, fn(_, {history, list}) ->
      apply_dance(moves, history, list)
    end)
    to_string(list)
  end

  defp apply_dance(moves, history, list) do
    past = history[list]
    if past do
      {history, past}
    else
      new_list = Enum.reduce(moves, list, &dance_move/2)
      history = Map.put(history, list, new_list)
      {history, new_list}
    end
  end

  defp dance_move({"s", num}, list) do
    {rest, start} = Enum.split(list, -1 * num)
    start ++ rest
  end

  defp dance_move({"x", first, second}, list) do
    first_value = Enum.at(list, first)
    second_value = Enum.at(list, second)
    list = List.replace_at(list, first, second_value)
    List.replace_at(list, second, first_value)
  end

  defp dance_move({"p", first, second}, list) do
    first_index = Enum.find_index(list, &(&1 == first))
    second_index = Enum.find_index(list, &(&1 == second))
    list = List.replace_at(list, first_index, second)
    List.replace_at(list, second_index, first)
  end

  defp dance_move(move, list) do
    IO.inspect move
    list
  end

  defp parse_move(move) do
    [command | rest] = String.graphemes(move)
    if command == "s" do
      {command, String.to_integer(to_string(rest))}
    else
      [first, second] = to_string(rest)
      |> String.split("/")
      if command == "x" do
        {command, String.to_integer(first), String.to_integer(second)}
      else
        {command, first, second}
      end
    end
  end
end
