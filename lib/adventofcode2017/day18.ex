defmodule Day18 do
  def process(file) do
    {:ok, contents} = File.read(file)
    commands = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, " ")))

    registers = %{}
    Stream.iterate({registers, 0}, fn({registers, counter}) ->
      instruction = Enum.at(commands, counter)
      process_instruction(instruction, counter, registers)
    end)
    |> Stream.map(&(elem(&1, 0)["rcv"]))
    |> Stream.filter(&(&1))
    |> Enum.take(1)
  end

  defp process_instruction(["set", reg, value], counter, registers) do
    value = register_or_value(registers, value)
    {Map.put(registers, reg, value), counter+1}
  end

  defp process_instruction(["add", reg, value], counter, registers) do
    value = String.to_integer(value)
    {Map.update(registers, reg, value, fn(add) -> add + value end), counter+1}
  end

  defp process_instruction(["mul", reg, mult], counter, registers) do
    value = register_or_value(registers, mult)
    {Map.update(registers, reg, 0, fn(reg) -> reg * value end), counter+1}
  end

  defp process_instruction(["mod", reg, value], counter, registers) do
    value = register_or_value(registers, value)
    {Map.update(registers, reg, 0, fn(mod) -> rem(mod, value) end), counter+1}
  end

  defp process_instruction(["snd", reg], counter, registers) do
    reg = registers[reg]
    {Map.put(registers, "snd", reg), counter+1}
  end

  defp process_instruction(["rcv", reg], counter, registers) do
    reg = registers[reg]
    if reg != 0 do
      {Map.put(registers, "rcv", registers["snd"]), counter+1}
    else
      {registers, counter+1}
    end
  end

  defp process_instruction(["jgz", reg, value], counter, registers) do
    reg = registers[reg]
    value = register_or_value(registers, value)
    if reg > 0 do
      {registers, counter+value}
    else
      {registers, counter+1}
    end
  end

  defp process_instruction(_, counter, registers) do
    {registers, counter+1}
  end

  defp register_or_value(registers, arg) do
    value = registers[arg]
    if value do
      value
    else
      String.to_integer(arg)
    end
  end
end
