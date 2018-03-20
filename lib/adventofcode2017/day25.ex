defmodule Day25 do
  defmodule Turing do
    defstruct cursor: 0, tape: %{}, state: "a"
  end

  def checksum(checksum) do
    turing = %Turing{}
    %Turing{tape: tape} = Stream.iterate(turing, fn(turing) ->
      %Turing{state: state, tape: tape, cursor: cursor} = turing
      value = tape[cursor] || 0
      {new_cursor, value, state} = case {state, value} do
        {"a",0} -> {cursor+1, 1, "b"}
        {"a",1} -> {cursor+1, 0, "c"}
        {"b",0} -> {cursor-1, 0, "a"}
        {"b",1} -> {cursor+1, 0, "d"}
        {"c",0} -> {cursor+1, 1, "d"}
        {"c",1} -> {cursor+1, 1, "a"}
        {"d",0} -> {cursor-1, 1, "e"}
        {"d",1} -> {cursor-1, 0, "d"}
        {"e",0} -> {cursor+1, 1, "f"}
        {"e",1} -> {cursor-1, 1, "b"}
        {"f",0} -> {cursor+1, 1, "a"}
        {"f",1} -> {cursor+1, 1, "e"}
      end
      %Turing{cursor: new_cursor, tape: Map.put(tape, cursor, value), state: state}
    end)
    |> Enum.take(checksum)
    |> List.last
    |> IO.inspect

    Enum.count(tape, fn({_,v}) ->
      v == 1
    end)
  end
end
