defmodule Day22 do
  def infect(input) do
    {:ok, contents} = File.read(input)

    start = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({rows, column}, map) ->
      Enum.reduce(rows, map, fn({state, row}, map) ->
        Map.put(map, {row*1.0, column*1.0}, state)
      end)
    end)

    start_node = start_node(start)
    |> IO.inspect
    Stream.iterate({0, start, start_node}, &next_state/1)
    |> Enum.take(10001)
    |> List.last
  end

  defp next_state({infections, state, %{position: position, direction: direction}}) do
    {infections, state} = Map.get_and_update(state, position, fn(infect_status) ->
      case infect_status do
        "#" -> {infections, "."}
        _ -> {infections+1, "#"}
      end
    end)

    current_node = state[position]
    direction = if current_node == "#" do
      turn_left(direction)
    else
      turn_right(direction)
    end

    {cx, cy} = case direction do
      "u" -> {0, -1}
      "l" -> {-1, 0}
      "r" -> {1, 0}
      "d" -> {0, 1}
    end
    {x, y} = position
    node = {x + cx, y + cy}

    {infections, state, %{position: node, direction: direction}}
  end

  defp turn_left(direction) do
    case direction do
      "u" -> "l"
      "l" -> "d"
      "d" -> "r"
      "r" -> "u"
    end
  end

  defp turn_right(direction) do
    case direction do
      "u" -> "r"
      "l" -> "u"
      "d" -> "l"
      "r" -> "d"
    end
  end

  def start_node(map) do
    sqrt = :math.sqrt(Map.size(map))
    start = (sqrt - 1) / 2
    %{position: {start, start}, direction: "u"}
  end
end
