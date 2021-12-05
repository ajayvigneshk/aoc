defmodule AocTest.HydroThermal do
  use ExUnit.Case
  alias Aoc.HydroThermal

  test "Part 1, without diagonals" do
    assert 7318 = HydroThermal.overlap("test/day5.txt", :no_include_diagonal)
  end

  test "Part 2, with diagonals" do
    assert 19939 = HydroThermal.overlap("test/day5.txt", :include_diagonal)
  end
end
