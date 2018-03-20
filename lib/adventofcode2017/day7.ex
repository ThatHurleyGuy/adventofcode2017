defmodule Day7 do
  def bottom_program(file) do
    parse_program(file)
    |> Enum.find(fn {_, {_weight, parent}} -> parent == -1 end)
    |> elem(0)
  end

  def balance(file) do
    program = parse_program(file)
    {bottom_program, _} = Enum.find(program, fn {_, {_weight, parent}} -> parent == -1 end)
    weights = calculate_weights(program, bottom_program)

    # Found by just recursing on the imbalanced node
    {_, children} = weights["zuahdoy"]
    [first, second] = Enum.map(children, fn(child) ->
      weight = weights[child]
      |> elem(0)
      IO.inspect "Child: #{child} Weight: #{elem(program[child], 0)} Total Weight: #{weight}"
      weight
    end)
    |> Enum.uniq

    "Difference: #{abs(first - second)}"
  end

  defp parse_program(file) do
    {:ok, contents} = File.read(file)
    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{}, fn(line, disjoint_set) ->
      {tower, weight, children} = parse_line(line)

      disjoint_set = Map.update(disjoint_set, tower, {weight, -1}, fn({_, parent}) ->
        {weight, parent}
      end)

      Enum.reduce(children, disjoint_set, fn(child, disjoint_set) ->
        Map.update(disjoint_set, child, {-1, tower}, fn({weight, _}) ->
          {weight, tower}
        end)
      end)
    end)
  end

  defp parse_line(line) do
    [_, tower, weight | tail] = Regex.run(~r{(\w+) \((\d+)\)( -> ([\w, ]+))?}, line)
    weight = String.to_integer(weight)

    if tail == [] do
      {tower, weight, []}
    else
      [_, children] = tail
      children = String.split(children, ", ")
      {tower, weight, children}
    end
  end

  defp calculate_weights(program, tower, weights \\ %{}) do
    {tower_weight, _} = program[tower]
    children = children(program, tower)
    weights = Enum.reduce(children, weights, fn(child, weights) ->
      calculate_weights(program, child, weights)
    end)
    total_weight = Enum.reduce(children, tower_weight, fn(tower, total_weight) -> total_weight + elem(weights[tower], 0) end)

    Map.put(weights, tower, {total_weight, children})
  end

  defp children(program, tower) do
    Enum.reduce(program, [], fn({current_tower, {_, parent}}, children) ->
      if parent == tower do
        [current_tower | children]
      else
        children
      end
    end)
  end
end
