defmodule Day20 do

  defmodule Point do
    defstruct [:position, :velocity, :acceleration]
  end

  def count_left(file) do
    process(file, true)
    |> length
  end

  def find_closest(file) do
    points = process(file)

    distances = distance(points)
    |> Enum.with_index

    {_, point} = Enum.min_by(distances, fn({distance, _}) ->
      distance
    end)
    point
  end

  def process(file, kill_duplicates \\ false) do
    {:ok, contents} = File.read(file)
    points = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)

    Enum.reduce(1..10000, points, fn(_, points) ->
      points = tick(points)
      if kill_duplicates do
        remove_copied(points, fn(%{position: position}) -> position end)
      else
        points
      end
    end)
  end

  defp distance(points) do
    Enum.map(points, fn(%{position: {xp,yp,zp}}) ->
      abs(xp) + abs(yp) + abs(zp)
    end)
  end

  defp tick(points) do
    Enum.map(points, fn(point) ->
      %{position: position, velocity: velocity, acceleration: acceleration} = point
      {xp, yp, zp} = position
      {xv, yv, zv} = velocity
      {xa, ya, za} = acceleration

      xv = xv + xa
      yv = yv + ya
      zv = zv + za
      xp = xv + xp
      yp = yv + yp
      zp = zv + zp

    %Point{position: {xp,yp,zp}, velocity: {xv,yv,zv}, acceleration: {xa,ya,za}}
    end)
  end

  defp parse_line(line) do
    [point, velocity, accel] = String.split(line, ", ")
    point = parse_coords(point)
    velocity = parse_coords(velocity)
    accel = parse_coords(accel)
    %Point{position: point, velocity: velocity, acceleration: accel}
  end

  defp parse_coords(coords) do
    [x, y, z] = String.slice(coords, 2..String.length(coords))
    |> String.slice(1..-2)
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    {x,y,z}
  end

  defp remove_copied(enum, function) do
    set = %{}
    counts = Enum.reduce(enum, set, fn(elem, set) ->
      Map.update(set, function.(elem), 1, &(&1 + 1))
    end)

    Enum.filter(enum, fn(elem) ->
      count = counts[function.(elem)]
      count == 1
    end)
  end
end
