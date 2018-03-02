defmodule Day20 do

  defmodule Point do
    defstruct [:position, :velocity, :acceleration]
  end

  def process(file) do
    {:ok, contents} = File.read(file)
    points = String.trim(contents)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)

    points = Enum.reduce(1..1000, points, fn(_, points) ->
      tick(points)
    end)

    distances = distance(points)
    |> Enum.with_index

    {_, point} = Enum.min_by(distances, fn({distance, _}) ->
      distance
    end)
    point
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
end
