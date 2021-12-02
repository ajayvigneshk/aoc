defmodule Aoc.Dive do
  @moduledoc """
  day 2, day_2
  """

  def calculate_v1(file_path) do
    res =
      File.stream!(file_path)
      |> Enum.reduce(%{horizontal: 0, depth: 0}, &calculate_v1/2)

    res.horizontal * res.depth
  end

  defp calculate_v1("forward " <> x, acc) do
    value = String.trim(x) |> String.to_integer()
    Map.update!(acc, :horizontal, fn current -> current + value end)
  end

  defp calculate_v1("down " <> x, acc) do
    value = String.trim(x) |> String.to_integer()
    Map.update!(acc, :depth, fn current -> current + value end)
  end

  defp calculate_v1("up " <> x, acc) do
    value = String.trim(x) |> String.to_integer()
    Map.update!(acc, :depth, fn current -> current - value end)
  end

  def calculate_v2(file_path) do
    res =
      File.stream!(file_path)
      |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, &calculate_v2/2)

    res.horizontal * res.depth
  end

  defp calculate_v2("forward " <> x, acc) do
    value = String.trim(x) |> String.to_integer()

    acc
    |> Map.update!(:horizontal, fn current -> current + value end)
    |> Map.update!(:depth, fn current -> current + value * Map.get(acc, :aim) end)
  end

  defp calculate_v2("down " <> x, acc) do
    value = String.trim(x) |> String.to_integer()
    Map.update!(acc, :aim, fn current -> current + value end)
  end

  defp calculate_v2("up " <> x, acc) do
    value = String.trim(x) |> String.to_integer()
    Map.update!(acc, :aim, fn current -> current - value end)
  end
end
