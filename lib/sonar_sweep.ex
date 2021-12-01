defmodule Aoc.SonarSweep do
  @moduledoc """
  day 1, day_1
  """

  # Without conversion "1000" > "997" comes out false(as it should) in elixir (sigh) and had to break my head for sometime
  def count_increase(file_path, window_size) when is_binary(file_path) do
    measurements =
      File.read!(file_path) |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

    count_increase(measurements, window_size)
  end

  def count_increase(measurements, window_size) do
    [_head | rest] = measurements
    window_func = fn list -> window_sum(list, window_size) end
    count_increase_sliding(rest, {measurements, 0}, window_func)
  end

  defp count_increase_sliding(measurements, {prev, count}, window_func) do
    case measurements do
      [] ->
        count

      [_head | tail] ->
        if window_func.(measurements) > window_func.(prev) do
          count_increase_sliding(tail, {measurements, count + 1}, window_func)
        else
          count_increase_sliding(tail, {measurements, count}, window_func)
        end
    end
  end

  defp window_sum(list, size) do
    ## Not finding length here as it's O(n) and more importantly the correctness of the program isn't affected without it
    Enum.take(list, size) |> Enum.sum()
  end

  # This was the original code for v1, then I realized it's a special case of above with window size =1 
  # def count_increase([head | rest]) do
  #   {_, count} =
  #     Enum.reduce(rest, {head, 0}, fn
  #       measurement, {prev_measurement, count} when measurement >= prev_measurement ->
  #         {measurement, count + 1}

  #       measurement, {_prev_measurement, count} ->
  #         {measurement, count}
  #     end)

  #   count
  # end
end
