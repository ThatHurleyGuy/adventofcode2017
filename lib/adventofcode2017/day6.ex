defmodule Day6 do
  def count_steps(file) do
    memory = build_memory(file)
    {total_steps, _} = count_redistributions(memory)
    total_steps
  end

  def count_infinite_loop(file) do
    memory = build_memory(file)
    {_, steps_in_cycle} = count_redistributions(memory)
    steps_in_cycle
  end

  defp build_memory(file) do
    {:ok, contents} = File.read(file)
    String.trim(contents)
    |> String.split(~r{\s+})
    |> Enum.map(&(String.to_integer(&1) + 0.0))
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({blocks, bank}, memory) ->
      Map.put(memory, bank, blocks)
    end)
  end

  defp count_redistributions(memory, history \\ %{}, step \\ 0) do
    if Map.has_key?(history, memory) do
      last_step = history[memory]
      {step, step - last_step}
    else
      history = Map.put(history, memory, step)
      memory = redistribute(memory)
      count_redistributions(memory, history, step + 1)
    end
  end

  defp redistribute(memory) do
    {bank_to_redistribute, blocks} = largest_block(memory)

    memory = Map.put(memory, bank_to_redistribute, 0)
    memory_size = map_size(memory)
    0..(memory_size - 1)
    |> Enum.reduce(memory, fn(bank, memory) ->
      distance = distance(bank, bank_to_redistribute, memory_size)
      blocks_to_move = :math.floor(blocks / memory_size)
      leftover = rem(round(blocks), round(memory_size))
      blocks = if distance > 0 && distance <= leftover do
        blocks_to_move + 1
      else
        blocks_to_move
      end

      Map.update!(memory, bank, &(&1 + blocks))
    end)
  end

  defp distance(bank, bank_to_redistribute, size) do
    distance = if bank_to_redistribute > bank do
      size - bank_to_redistribute + bank
    else
      bank - bank_to_redistribute
    end
    abs(distance)
  end

  defp largest_block(memory) do
    Enum.max_by(memory, fn {_, blocks} ->
      blocks
    end)
  end
end
