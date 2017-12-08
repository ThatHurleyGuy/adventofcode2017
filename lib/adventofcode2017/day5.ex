defmodule Day5 do
  def part1(file) do
    count_steps(file, &({&1, &1 + 1}))
  end

  def part2(file) do
    count_steps(file, fn(step) ->
      if step >= 3 do
        {step, step - 1}
      else
        {step, step + 1}
      end
    end)
  end

  def count_steps(file, step_function) do
    {:ok, contents} = File.read(file)
    program = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({jump, index}, y) ->
      Map.put(y, index, jump)
    end)

    count_steps_in_program(program, 0, step_function)
  end

  defp count_steps_in_program(program, instruction, _) when map_size(program) <= instruction, do: 0
  defp count_steps_in_program(program, instruction, step_function) do
    {jump, program} = Map.get_and_update(program, instruction, step_function)
    1 + count_steps_in_program(program, instruction + jump, step_function)
  end
end
