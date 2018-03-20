defmodule Day24 do
  def process(file) do
    {:ok, contents} = File.read(file)

    nodes = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "/"))
    |> Enum.map(fn([x,y]) -> [String.to_integer(x),String.to_integer(y)] end)

    open_set = [0,0]
    closed_set = MapSet.new

    best_path(open_set, closed_set, nodes)
  end

  defp best_path(head, closed_set, nodes) do
    closed_set = MapSet.put(closed_set, Enum.sort(head))
    children = children(head, closed_set, nodes)
    children_weights = Enum.map(children, fn(child) ->
      child = if Enum.at(head, 1) == hd(child) do
        child
      else
        Enum.reverse(child)
      end
      best_path(child, closed_set, nodes)
    end)

    max = if children_weights == [] do
      {0, 0}
    else
      Enum.reduce(children_weights, {0,0}, fn({length, weight}, {max_length, max_weight}) ->
        if length >= max_length && weight >= max_weight do
          {length, weight}
        else
          {max_length, max_weight}
        end
      end)
    end

    {elem(max, 0) + 1, Enum.sum(head) + elem(max, 1)}
  end

  defp children([_, second], closed_set, nodes) do
    Enum.filter(nodes, fn(node) ->
      if MapSet.member?(closed_set, Enum.sort(node)) do
        false
      else
        Enum.member?(node, second)
      end
    end)
  end
end
