defmodule AocTest.Dive do
  
  use ExUnit.Case
  alias Aoc.Dive

  test "Test for v1 version of calculation" do
    assert 1727835 = Dive.calculate_v1("test/day2.txt")   
  end

  test "Test for v2 version of calculation" do
    assert 1544000595 = Dive.calculate_v2("test/day2.txt")   
  end
end
