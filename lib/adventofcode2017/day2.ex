defmodule Day2 do
  def checksum(file) do
    process_file(file, fn(line) ->
      Enum.max(line) - Enum.min(line)
    end)
  end

  def checksum_division(file) do
    process_file(file, fn(line) ->
      check_line_division(line)
    end)
  end

  defp check_line_division(line) do
    Enum.find_value(line, fn(dividend) ->
      Enum.find_value(line, fn(divisor) ->
        if dividend > divisor do
          quotient = dividend / divisor
          if quotient == round(quotient) do
            quotient
          else
            nil
          end
        else
          nil
        end
      end)
    end)
  end

  defp process_file(file, f) do
    {:ok, contents} = File.read(file)
    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&(String.split(&1, ~r{\s+})))
    |> Enum.reduce(0, fn(line, sum) ->
      line = Enum.map(line, &String.to_integer/1)
      sum + f.(line)
    end)
  end
end
