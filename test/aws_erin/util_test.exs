defmodule AwsErin.UtilTest do
  use ExUnit.Case
  doctest AwsErin.Util

  test "hash" do
    assert AwsErin.Util.hash("erin") ==
             <<124, 188, 203, 12, 76, 170, 223, 159, 205, 181, 30, 228, 87, 168, 40, 204, 114,
               164, 88, 121, 131, 27, 91, 151, 138, 226, 226, 206, 252, 68, 151, 5>>
  end
end
