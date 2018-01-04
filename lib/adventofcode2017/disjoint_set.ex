defmodule DisjointSet do
  def new do
    %{}
  end

  def add_new(set, node) do
    Map.put_new(set, node, {node, 0})
  end

  def find(set, node) do
    {node_parent, node_rank} = set[node]
    if node_parent == node do
      {{node_parent, node_rank}, set}
    else
      {{node_parent, node_rank}, set} = find(set, node_parent)
      set = Map.put(set, node, {node_parent, node_rank})
      {{node_parent, node_rank}, set}
    end
  end

  def union(set, node, neighbor) do
    {{node_parent, node_rank}, set} = find(set, node)
    {{neighbor_root, neighbor_rank}, set} = find(set, neighbor)
    cond do
      node_parent == neighbor_root -> set
      node_rank < neighbor_rank -> Map.put(set, node_parent, {neighbor_root, neighbor_rank})
      node_rank > neighbor_rank -> Map.put(set, neighbor_root, {node_parent, node_rank})
      true -> Map.put(set, node_parent, {node_parent, node_rank+1}) |> Map.put(neighbor_root, {node_parent, node_rank + 1})
    end
  end
end
