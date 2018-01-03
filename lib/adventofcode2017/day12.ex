defmodule Day12 do
  def count_groups(file) do
    {:ok, contents} = File.read(file)
    set = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> build_disjoint_set

    Enum.reduce(set, MapSet.new, fn({_, {node, _}}, groups) ->
      {{node_parent, _}, _} = find(set, node)
      MapSet.put(groups, node_parent)
    end)
    |> MapSet.size
  end

  def count(file) do
    {:ok, contents} = File.read(file)
    set = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> build_disjoint_set

    {{parent, _}, set} = find(set, 0)

    Enum.filter(set, fn({_, {node, _}}) ->
      {{node_parent, _}, _} = find(set, node)
      node_parent == parent
    end)
    |> length
  end

  defp build_disjoint_set(nodes) do
    Enum.reduce(nodes, %{}, fn({node, neighbors}, set) ->
      set = Map.put_new(set, node, {node, 0})
      Enum.reduce(neighbors, set, fn(neighbor, set) ->
        set = Map.put_new(set, neighbor, {neighbor, 0})
        merge(set, node, neighbor)
      end)
    end)
  end

  defp merge(set, node, neighbor) do
    {{node_parent, node_rank}, set} = find(set, node)
    {{neighbor_root, neighbor_rank}, set} = find(set, neighbor)
    cond do
      node_parent == neighbor_root -> set
      node_rank < neighbor_rank -> Map.put(set, node_parent, {neighbor_root, neighbor_rank})
      node_rank > neighbor_rank -> Map.put(set, neighbor_root, {node_parent, node_rank})
      true -> Map.put(set, node_parent, {node_parent, node_rank+1}) |> Map.put(neighbor_root, {node_parent, node_rank + 1})
    end
  end

  defp find(set, node) do
    {node_parent, node_rank} = set[node]
    if node_parent == node do
      {{node_parent, node_rank}, set}
    else
      {{node_parent, node_rank}, set} = find(set, node_parent)
      set = Map.put(set, node, {node_parent, node_rank})
      {{node_parent, node_rank}, set}
    end
  end

  defp parse_line(line) do
    [index, connections] = String.split(line, " <-> ")
    index = String.to_integer(index)
    connections = String.split(connections, ", ")
    |> Enum.map(&String.to_integer/1)
    {index, connections}
  end
end
