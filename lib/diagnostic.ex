defmodule Aoc.Diagnostic do
  @moduledoc """
  day3, day3
  notes: 
  """
  defp parse_measurements(file_path) do
    File.read!(file_path)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn num_list -> Enum.map(num_list, &String.to_integer/1) end)
  end

  ## Part 2

  def life_support_rating(file_path) do
    measurements = parse_measurements(file_path)

    oxygen_rating = life_support_rating(&oxygen_decider/2, measurements, 0)
    carbon_rating = life_support_rating(&carbon_decider/2, measurements, 0)
    oxygen_rating * carbon_rating
  end

  def life_support_rating(_decider_func, [head | []], _index) do
    Integer.undigits(head, 2)
  end

  def life_support_rating(decider_func, measurements, index) do
    {digit_sums, count} =
      measurements
      |> Enum.map(fn measurement -> Enum.at(measurement, index) end)
      |> Enum.reduce({0, 0}, fn first_digit, {sum, count} ->
        {first_digit + sum, count + 1}
      end)

    filter_value = decider_func.(digit_sums, count)

    filtered_measurements =
      measurements
      |> Enum.filter(fn measurement -> Enum.at(measurement, index) == filter_value end)

    life_support_rating(decider_func, filtered_measurements, index + 1)
  end

  def oxygen_decider(sum, count) do
    cond do
      sum == count / 2 -> 1
      sum > count / 2 -> 1
      true -> 0
    end
  end

  def carbon_decider(sum, count) do
    cond do
      sum == count / 2 -> 0
      sum < count / 2 -> 1
      true -> 0
    end
  end

  # Part 1 
  def power_consumption(file_path) when is_binary(file_path) do
    parse_measurements(file_path)
    |> calculate()
  end

  def calculate([head | rest]) do
    {digit_sums, count} =
      rest
      |> Enum.reduce({head, 1}, fn digits, {sum, count} ->
        {sum_digits(digits, sum), count + 1}
      end)

    gamma_rate =
      digit_sums
      |> Enum.map(fn digit_sum -> gamma_decider(digit_sum, count) end)
      |> Integer.undigits(2)

    epsilon_rate =
      digit_sums
      |> Enum.map(fn digit_sum -> epsilon_decider(digit_sum, count) end)
      |> Integer.undigits(2)

    gamma_rate * epsilon_rate
  end

  def sum_digits(val1, val2) do
    Enum.zip(val1, val2)
    |> Enum.map(fn {digit1, digit2} -> digit1 + digit2 end)
  end

  def gamma_decider(sum, count) do
    cond do
      sum > count / 2 -> 1
      true -> 0
    end
  end

  # This just seems like the complement of gamma, still ...
  def epsilon_decider(sum, count) do
    cond do
      sum < count / 2 -> 1
      true -> 0
    end
  end
end
