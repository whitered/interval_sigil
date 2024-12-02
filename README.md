# Interval sigils and conversion utilities

Library for defining and converting time intervals.

### Features

- Definition of time intervals in a human-readable format.
- Conversion intervals to various units, including fractional values.
- Support for multiple time units within a single definition.

## Examples

Default conversion to milliseconds
```elixir
    iex> import IntervalSigil
    iex> ~i"2m 15s"
    135000
```

Conversion to alternative units
```elixir
    iex> ~i"2m 15s"s
    135
```

Floating-point results with uppercase sigil `~I`
```elixir
    iex> ~I"6D"M
    0.2 # Converts days to months (1 month = 30 days)

    iex> ~I"75s"m
    1.25 # Converts seconds to minutes
```

Explicit functions `to_integer` and `to_float` to convert time intervals
```elixir
    iex> IntervalSigil.to_integer("3h 15m")
    11700000

    iex> IntervalSigil.to_integer("3h 15m", "h")
    3

    iex> IntervalSigil.to_float("3h 15m", "h")
    3.25
```

### Supported Units

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

### Additional Information

- Intervals can include multiple units ordered from largest to smallest, either separated by spaces (e.g., `~i"1h 30m"`) or combined (e.g., `~i"1h30m"`).
- The `~i` sigil converts to integer values, while `~I` provides fractional results.

## Installation

```elixir
def deps do
  [
    {:interval_sigil, "~> 0.1.1"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/interval_sigil>.
