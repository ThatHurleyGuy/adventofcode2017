defmodule Day23 do
  def process_fast do
    d = e = f = h = 0
    b = 93 * 100 + 100000
    c = b + 17000
    loop3(b,c,d,e,f,h)
  end

  defp loop3(b,c,_,_,_,h) do
    f = 1
    d = 2
    e = 2

    {b,d,e,f} = loop2(b,d,e,f)
    h = if f == 0 do
      h+1
    else
      h
    end

    if b == c do
      h
    else
      b = b + 17
      loop3(b,c,d,e,f,h)
    end
  end

  defp loop2(b,d,e,f) do
    divisible = d..(b-1)
    |> Enum.any?(fn(d) -> rem(b, d) == 0 end)

    if divisible do
      {b,d,e,0}
    else
      {b,d,e,f}
    end
  end

  def process(file) do
    {:ok, contents} = File.read(file)
    commands = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, " ")))

    registers = %{
      "mul" => 0,
      "a" => 1,
      "b" => 0,
      "c" => 0,
      "d" => 0,
      "e" => 0,
      "f" => 0,
      "g" => 0,
      "h" => 0
    }
    Stream.iterate({registers, 0}, fn({registers, counter}) ->
      instruction = Enum.at(commands, counter)
      process_instruction(instruction, counter, registers)
    end)
    |> Enum.find(fn({_, counter}) ->
      counter >= length(commands)
    end)
    |> elem(0)
    |> Map.get("h")
  end

  defp process_instruction(["set", reg, value], counter, registers) do
    value = register_or_value(registers, value)
    {Map.put(registers, reg, value), counter+1}
  end

  defp process_instruction(["sub", reg, value], counter, registers) do
    value = register_or_value(registers, value)
    {Map.update(registers, reg, value, fn(add) -> add - value end), counter+1}
  end

  defp process_instruction(["mul", reg, mult], counter, registers) do
    value = register_or_value(registers, mult)
    registers = Map.update(registers, reg, 0, fn(reg) -> reg * value end)
    registers = Map.update!(registers, "mul", &(&1 + 1))
    {registers, counter+1}
  end

  defp process_instruction(["jnz", reg, value], counter, registers) do
    reg = registers[reg]
    if reg != 0 do
      value = register_or_value(registers, value)
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
