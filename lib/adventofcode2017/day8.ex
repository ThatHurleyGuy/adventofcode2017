defmodule Day8 do
  def largest_register(file) do
    {:ok, contents} = File.read(file)
    registers = %{}

    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, " ")))
    |> Enum.reduce(registers, &process_line/2)
    |> Map.values
    |> Enum.max
  end

  defp process_line([modify_register, command, difference, "if", check_register, operation, check_value], registers) do
    if check_operation(check_register, operation, check_value, registers) do
      run_operation(modify_register, command, difference, registers)
    else
      registers
    end
  end

  defp run_operation(register, operation, difference, registers) do
    difference = String.to_integer(difference)
    if operation == "inc" do
      Map.update(registers, register, difference, fn(register) -> register + difference end)
    else
      Map.update(registers, register, 0 - difference, fn(register) -> register - difference end)
    end
  end

  defp check_operation(check_register, operation, check_value, registers) do
    register_value = Map.get(registers, check_register, 0)
    check_value = String.to_integer(check_value)

    case operation do
      "==" -> register_value == check_value
      "!=" -> register_value != check_value
      ">" -> register_value > check_value
      ">=" -> register_value >= check_value
      "<" -> register_value < check_value
      "<=" -> register_value <= check_value
    end
  end
end
