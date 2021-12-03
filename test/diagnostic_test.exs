defmodule AocTest.Dignostic do
  
  use ExUnit.Case
  alias Aoc.Diagnostic

  test "power_rating check" do
    assert 1092896 == Diagnostic.power_consumption("test/day3.txt")
  end

  test "life_support_rating check" do
    assert 4672151 == Diagnostic.life_support_rating("test/day3.txt")
  end
end
