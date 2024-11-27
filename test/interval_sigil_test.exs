defmodule IntervalSigilTest do
  use ExUnit.Case
  import IntervalSigil
  doctest IntervalSigil

  describe "Sigil ~i" do
    test "default unit = ms" do
      assert ~i"1s" == 1000
      assert ~i"1m2s" == 62000
      assert ~i" 1m 2s " == 62000
      assert ~i"1Y2M3W4D6h6m7s8ms9us10ns" == 38_901_967_008
    end

    test "custom units" do
      assert ~i"1s"m == 0
      assert ~i"1s"us == 1_000_000
      assert ~i"1s"ns == 1_000_000_000
      assert ~i"4h20m"m == 260
    end
  end

  describe "Sigil ~I" do
    test "default unit = ms" do
      assert ~I"1s" == 1000.0
      assert ~I" 1m 2s 3ms 4us" == 62003.004
      assert ~I"1Y2M3W4D6h6m7s8ms9us10ns" == 38_901_967_008.00901
    end

    test "custom units" do
      assert ~I"1m3s"m == 1.05
      assert ~I"123us"ms == 0.123
      assert ~I"1D"W == 0.14285714285714285
    end
  end
end
