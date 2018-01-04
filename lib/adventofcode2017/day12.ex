defmodule Day12 do
  def count_groups(file) do
    set = parse_file(file)

    Enum.reduce(set, MapSet.new, fn({_, {node, _}}, groups) ->
      {{node_parent, _}, _} = DisjointSet.find(set, node)
      MapSet.put(groups, node_parent)
    end)
    |> MapSet.size
  end

  def count(file) do
    set = parse_file(file)
    {{parent, _}, set} = DisjointSet.find(set, 0)

    Enum.filter(set, fn({_, {node, _}}) ->
      {{node_parent, _}, _} = DisjointSet.find(set, node)
      node_parent == parent
    end)
    |> length
  end

  defp parse_file(file) do
    {:ok, contents} = File.read(file)
    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> build_disjoint_set
  end

  defp build_disjoint_set(nodes) do
    Enum.reduce(nodes, %{}, fn({node, neighbors}, set) ->
      set = DisjointSet.add_new(set, node)
      Enum.reduce(neighbors, set, fn(neighbor, set) ->
        set = DisjointSet.add_new(set, neighbor)
        DisjointSet.union(set, node, neighbor)
      end)
    end)
  end

  defp parse_line(line) do
    [index, connections] = String.split(line, " <-> ")
    index = String.to_integer(index)
    connections = String.split(connections, ", ")
    |> Enum.map(&String.to_integer/1)
    {index, connections}
  end
end
