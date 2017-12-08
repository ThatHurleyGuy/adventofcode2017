defmodule Day5 do
  def count_steps(file) do
    {:ok, contents} = File.read(file)
    program = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({jump, index}, y) ->
      Map.put(y, index, jump)
    end)

    count_steps_in_program(program, 0)
  end

  defp count_steps_in_program(program, instruction) when map_size(program) <= instruction, do: 0
  defp count_steps_in_program(program, instruction) do
    {jump, program} = Map.get_and_update(program, instruction, &({&1, &1 + 1}))
    1 + count_steps_in_program(program, instruction + jump)
  end
end
