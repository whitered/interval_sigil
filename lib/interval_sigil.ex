defmodule IntervalSigil do
  @moduledoc """
  Interval sigils ~i and ~I

  Allow easily define time intervals:

  ## Examples:

    iex> import IntervalSigil
    iex> ~i"2m 15s"
    135000

  Converts interval into milliseconds by default, other units available as modifiers:

    iex> ~i"2m 15s"s
    135

  Available units are:
  - nanosecond (ns)
  - microsecond (us)
  - millisecond (ms, default)
  - second (s)
  - minute (m)
  - hour (h)
  - day (D)
  - week (W)
  - month (M, =30 days)
  - year (Y, =365 days)

  Interval may consist of multiple units from bigger to smaller, joined together or separated by space(s):

  Also the '~I' sigil available, allowing to convert to float values:

    iex> ~I"6D"M
    0.2
    iex> ~I"75s"m
    1.25
  """

  @nanosecond 1
  @microsecond 1000
  @millisecond 1000 * @microsecond
  @second 1000 * @millisecond
  @minute 60 * @second
  @hour 60 * @minute
  @day 24 * @hour
  @week 7 * @day
  @month 30 * @day
  @year 365 * @day

  @units [
    {"Y", @year},
    {"M", @month},
    {"W", @week},
    {"D", @day},
    {"h", @hour},
    {"m", @minute},
    {"s", @second},
    {"ms", @millisecond},
    {"us", @microsecond},
    {"ns", @nanosecond}
  ]

  @doc """
  Handles the sigil ~i for integer intervals.

  This sigil converts string representation of interval to integer number of units.
  """
  def sigil_i(string, []), do: sigil_i(string, ~c"ms")

  def sigil_i(string, unit) do
    value = to_nano(string)
    unit = unit_to_nano(unit)
    div(value, unit)
  end

  @doc """
  Handles the sigil ~I for float intervals.

  This sigil converts string representation of interval to float number of units.
  """
  def sigil_I(string, []), do: sigil_I(string, ~c"ms")

  def sigil_I(string, unit) do
    value = to_nano(string)
    unit = unit_to_nano(unit)
    value / unit
  end

  defp to_nano(string) when is_binary(string), do: to_nano(string, @units, 0)

  defp to_nano("", _, acc), do: acc

  defp to_nano(string, units, acc) when is_binary(string) do
    case Regex.run(~r/^(?:\s*)([[:digit:]]+)([[:alpha:]]+)(?:\s*)(.*)$/, string,
           capture: :all_but_first
         ) do
      [num, unit, rest] -> to_nano([String.to_integer(num), unit, rest], units, acc)
      nil -> raise "Incorrect interval format"
    end
  end

  defp to_nano([num, unit, rest], [{unit, unit_value} | rest_units], acc) do
    to_nano(rest, rest_units, acc + num * unit_value)
  end

  defp to_nano([num, unit, rest], [_ | rest_units], acc) do
    to_nano([num, unit, rest], rest_units, acc)
  end

  defp to_nano([_num, unit, _rest], [], _),
    do: raise("Unexpected unit \"#{unit}\" used in interval")

  defp unit_to_nano(unit) when is_list(unit) do
    unit_str = List.to_string(unit)

    case Enum.find(@units, &(elem(&1, 0) == unit_str)) do
      {_, value} -> value
      nil -> raise "Unexpected unit \"#{unit}\" used as sigil modifier"
    end
  end
end
