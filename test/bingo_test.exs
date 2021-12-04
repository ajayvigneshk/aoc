defmodule AocTest.Bingo do
  use ExUnit.Case
  alias Aoc.Bingo

  test "part 1 assert" do
    assert 5685 = Bingo.simulate_game("test/day4.txt")
  end

  test "part 2 assert" do
    assert 21070 = Bingo.simulate_game_2("test/day4.txt")
  end
end
