defmodule Day4 do
  def count_valid_passwords(file) do
    count_valid_passwords(file, &(&1))
  end

  def count_valid_passwords_part_2(file) do
    count_valid_passwords(file, fn(line) ->
      Enum.map(line, &(Enum.sort(String.graphemes(&1))))
    end)
  end

  defp count_valid_passwords(file, transform_line) do
    {:ok, contents} = File.read(file)

    String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&(String.split(&1, " ")))
    |> Enum.map(&(transform_line.(&1)))
    |> Enum.count(fn(line) ->
      length(line) == length(Enum.uniq(line))
    end)
  end
end
