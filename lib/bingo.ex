defmodule Aoc.Bingo do
  @moduledoc """
  day 4, day_4
  TODO redo this with a genserver that maintains state, 
    each board is a server
  """
  def simulate_game(input_path) do
    {draws, boards} = parse_inputs(input_path)

    Enum.reduce_while(draws, %{no_bingo: boards}, fn
      # Assumes only one board can bingo for a draw, works for sample set :-D
      _draw, %{bingo: [result]} ->
        {:halt, result}

      draw, %{no_bingo: boards} ->
        {:cont, mark_and_check_all(boards, draw)}
    end)
  end

  def simulate_game_2(input_path) do
    {draws, boards} = parse_inputs(input_path)

    Enum.reduce_while(draws, %{no_bingo: boards}, fn
      draw, %{bingo: _, no_bingo: _} = acc -> {:cont, mark_and_check_all(acc, draw)}
      draw, %{no_bingo: _} = acc -> {:cont, mark_and_check_all(acc, draw)}
      _draw, %{bingo: [result]} -> {:halt, result}
    end)
  end

  def mark_and_check_all(%{no_bingo: boards}, draw) do
    mark_and_check_all(boards, draw)
  end

  def mark_and_check_all(boards, draw) do
    boards
    |> Enum.map(&mark_and_check_one(&1, draw))
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
  end

  def mark_and_check_one(board, draw) do
    marked_board =
      board
      |> Enum.map(fn row ->
        Enum.map(row, fn
          ^draw -> {draw, :strike}
          entry -> entry
        end)
      end)

    cond do
      check_bingo(marked_board) ->
        {:bingo, sum_unstriked(marked_board) * draw}

      true ->
        {:no_bingo, marked_board}
    end
  end

  def check_bingo(board) do
    check_row_wise(board) || check_column_wise(board)
  end

  def sum_unstriked(marked_board) do
    marked_board
    |> Enum.map(fn row ->
      row
      |> Enum.filter(fn
        {_, :strike} -> false
        _ -> true
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def check_row_wise(board) do
    board
    |> Enum.reduce(false, fn
      row, acc ->
        acc or
          Enum.all?(row, fn
            {_, :strike} -> true
            _ -> false
          end)
    end)
  end

  def check_column_wise(board) do
    board =
      board
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

    check_row_wise(board)
  end

  defp parse_boards(boards) do
    Enum.map(boards, fn board ->
      String.split(board, "\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, " ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
    end)
  end

  defp parse_inputs(file_path) do
    contents = File.read!(file_path)

    [head | rest] =
      contents
      |> String.split("\n\n", trim: true)

    draws =
      head
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards = parse_boards(rest)
    {draws, boards}
  end
end
