defmodule Day19 do
  def process(file) do
    {:ok, contents} = File.read(file)
    lines = String.trim_trailing(contents)
    |> String.split("\n")
    |> Enum.map(&String.trim(&1, "\n"))
    |> Enum.map(&String.graphemes/1)

    starting_point = starting_point(lines)
    trace_path(lines, starting_point, "d", {0, ""})
  end

  defp trace_path(lines, position, direction, {steps, string}) do
    {next_spot, char_at} = next_spot(lines, position, direction)

    case char_at do
      "|" -> trace_path(lines, next_spot, direction, {steps+1, string})
      "-" -> trace_path(lines, next_spot, direction, {steps+1, string})
      "+" -> trace_path(lines, next_spot, next_direction(lines, next_spot, direction), {steps+1, string})
      " " -> {steps+1, string}
      x -> trace_path(lines, next_spot, direction, {steps+1, string <> x})
    end
  end

  defp next_direction(lines, {x,y}, direction) do
    if direction == "u" || direction == "d" do
      left = Enum.at(Enum.at(lines, x), y-1)
      if left != "|" && left != " " do
        "l"
      else
        "r"
      end
    else
      up = Enum.at(Enum.at(lines, x-1), y)
      if up != "-" && up != " " do
        "u"
      else
        "d"
      end
    end
  end

  defp next_spot(lines, {x,y}, direction) do
    {x,y} = case direction do
      "u" -> {x-1, y}
      "d" -> {x+1, y}
      "l" -> {x, y-1}
      "r" -> {x, y+1}
    end
    {{x,y}, Enum.at(Enum.at(lines, x), y)}
  end

  defp starting_point([top | _]) do
    {0, Enum.find_index(top, &(&1 == "|"))}
  end
end
