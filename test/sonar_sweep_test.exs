defmodule AocTest.SonarSweep do
  
  use ExUnit.Case
  alias Aoc.SonarSweep

  test "Sliding window 1 with sample data" do
    assert 1681 = SonarSweep.count_increase("test/day1.txt",1)
  end
  test "Sliding window 3 with sample data" do
    assert 1704 = SonarSweep.count_increase("test/day1.txt",3)
  end
end
