defmodule Aoc.LanternFish do
  # @reset_lantern_timer 6
  # @new_lantern_timer 8
  def parse_input(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def tick2({prev_freq, prev_num_lanterns}) do
    new_freq =
      prev_freq
      |> Enum.reduce(%{}, fn
        {timer, count}, acc_freq when timer == 0 or timer == 7 ->
          Map.update(acc_freq, 6, count, fn current -> current + count end)

        {timer, count}, acc_freq ->
          Map.put(acc_freq, timer - 1, count)
      end)
      |> Map.put(8, prev_num_lanterns)

    num_new_lanterns = Map.get(new_freq, 0, 0)
    {new_freq, num_new_lanterns}
  end

  def num_lanterns2(input, days) do
    day1_freq = parse_input(input) |> Enum.frequencies()
    day1_num_lanterns = parse_input(input) |> Enum.filter(fn x -> x == 0 end) |> Enum.count()

    1..days
    |> Enum.reduce({day1_freq, day1_num_lanterns}, fn _, state -> tick2(state) end)
    |> elem(0)
    |> Map.values()
    |> Enum.sum()
  end

  # Becomes extremely slow due to exponential growth

  # def tick(state) do
  #   {new_state, new_lanterns_to_add} =
  #     state
  #     |> Enum.reduce({[], 0}, fn
  #       0, {new_state, new_lantern_count} ->
  #         {[@reset_lantern_timer | new_state], new_lantern_count + 1}

  #       timer, {new_state, new_lantern_count} ->
  #         {[timer - 1 | new_state], new_lantern_count}
  #     end)

  #   cond do
  #     new_lanterns_to_add != 0 ->
  #       new_lanterns = for _ <- 1..new_lanterns_to_add, do: @new_lantern_timer
  #       Enum.reverse(new_state) ++ new_lanterns

  #     true ->
  #       Enum.reverse(new_state)
  #   end
  # end

  # def num_lanterns(input, days) do
  #   init_state = parse_input(input)

  # 1..days
  # |> Enum.reduce(init_state, fn _, state -> tick(state) end)
  # |> Enum.count()
  # end
end
