defmodule Aoc.Whales do
  defp parse_input(input_str) do
    input_str
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp find_median(input) do
    sorted =
      input
      |> Enum.sort()

    middle_index = div(length(sorted), 2)
    Enum.at(sorted, middle_index)
  end

  def fuel(input_str) do
    input = parse_input(input_str)
    median = input |> find_median

    input
    |> Enum.reduce(0, fn value, acc -> acc + abs(value - median) end)
  end

  def fuel2(input_str) do
    input = parse_input(input_str)
    mean = input |> Enum.sum() |> div(length(input)) |> round()

    input
    |> Enum.reduce(0, fn value, acc ->
      fuel = div(abs(value - mean) * (abs(value - mean) + 1), 2)
      acc + fuel
    end)
  end
end
