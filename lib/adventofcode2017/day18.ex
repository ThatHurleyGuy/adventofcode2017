defmodule Day18 do
  def process_multiple(file) do
    {:ok, contents} = File.read(file)
    commands = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, " ")))

    registers1 = %{"p" => 0}
    registers2 = %{"p" => 1}
    Stream.iterate([{registers1, 0}, {registers2, 0}], fn([{registers1, counter1}, {registers2, counter2}]) ->
      instruction1 = Enum.at(commands, counter1)
      {registers1, counter1} = process_instruction(instruction1, counter1, registers1)
      instruction2 = Enum.at(commands, counter2)
      {registers2, counter2} = process_instruction(instruction2, counter2, registers2)

      {snd1, registers1} = Map.get_and_update(registers1, "snd", fn(value) ->
        {value, nil}
      end)
      {snd2, registers2} = Map.get_and_update(registers2, "snd", fn(value) ->
        {value, nil}
      end)
      registers1 = if snd2 do
        IO.inspect "sending"
        Map.update(registers1, "rcv", [snd2], fn(value) ->
          value ++ [snd2]
        end)
      else
        registers1
      end
      registers2 = if snd1 do
        Map.update(registers2, "rcv", [snd1], fn(value) ->
          value ++ [snd1]
        end)
      else
        registers2
      end
      [{registers1, counter1}, {registers2, counter2}]
    end)
    |> Enum.take(1000000)

    nil
  end

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
    value = register_or_value(registers, value)
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
    reg = register_or_value(registers, reg)
    {Map.put(registers, "snd", reg), counter+1}
  end

  defp process_instruction(["rcv", reg], counter, registers) do
    {rcv, registers} = Map.get_and_update(registers, "rcv", fn(rcv) ->
      case rcv do
        nil -> {nil, []}
        [] -> {nil, []}
        [head | rest] -> {head, rest}
      end
    end)
    if rcv do
      {Map.put(registers, reg, rcv), counter+1}
    else
      {registers, counter}
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
