defmodule Aoc.HydroThermal do
  @moduledoc """
  day 5, day_5
  """
  defmodule PointPair do
    defstruct [:first, :second]

    def from_file_line(line) do
      [left, right | []] =
        line
        |> String.split(" -> ", trim: true)

      {_x1, _y1} =
        first =
        left
        |> String.split(",", trim: true)
        |> List.to_tuple()

      {_x2, _y2} =
        second =
        right
        |> String.split(",", trim: true)
        |> List.to_tuple()

      from_tuple_pair(first, second)
    end

    def from_tuple_pair({x1, y1}, {x2, y2}) do
      %PointPair{
        first: {String.to_integer(x1), String.to_integer(y1)},
        second: {String.to_integer(x2), String.to_integer(y2)}
      }
    end

    def to_line(%PointPair{first: first, second: second}, include_diagonal \\ :include_diagonal) do
      to_line(first, second, include_diagonal)
    end

    defp to_line({x1, y1}, {x2, y1}, _) do
      x1..x2
      |> Stream.map(fn x -> {x, y1} end)
      |> Enum.to_list()
    end

    defp to_line({x1, y1}, {x1, y2}, _) do
      y1..y2
      |> Stream.map(fn y -> {x1, y} end)
      |> Enum.to_list()
    end

    defp to_line({x1, y1}, {x2, y2}, :include_diagonal) when abs(x1 - x2) == abs(y1 - y2),
      do: Enum.zip(x1..x2, y1..y2)

    defp to_line(_, _, _), do: []
  end

  def parse_inputs(input_path) do
    File.read!(input_path)
    |> String.splitter("\n", trim: true)
    |> Stream.map(&PointPair.from_file_line(&1))
    |> Enum.to_list()
  end

  def overlap(input_path, include_diagonal) do
    line_list =
      parse_inputs(input_path)
      |> Stream.map(fn pp -> PointPair.to_line(pp, include_diagonal) end)
      |> Stream.reject(fn
        [] -> true
        _ -> false
      end)
      |> Enum.flat_map(& &1)

    line_list
    |> Enum.frequencies()
    |> Enum.filter(fn {_point, occurrence} -> occurrence >= 2 end)
    |> Enum.count()
  end
end
