# Interval Sigils: `~i` and `~I`

**A utility for defining and converting time intervals in Elixir.**

The `IntervalSigil` library introduces the `~i` and `~I` sigils for intuitive and precise time intervals definition. 

## Features

- Convert time intervals from a human-readable format.
- Convert intervals to various units, including fractional values.
- Support for multiple time units within a single definition.

## Examples

### Default Conversion to Milliseconds
```elixir
    iex> import IntervalSigil
    iex> ~i"2m 15s"
    135000
```

### Conversion to Alternative Units
```elixir
    iex> ~i"2m 15s"s
    135
```

### Floating-Point Results with `~I`
```elixir
    iex> ~I"6D"M
    0.2 # Converts days to months (1 month = 30 days)

    iex> ~I"75s"m
    1.25 # Converts seconds to minutes
```

## Supported Units

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

## Additional Information

- Intervals can include multiple units ordered from largest to smallest, either separated by spaces (e.g., `~i"1h 30m"`) or combined (e.g., `~i"1h30m"`).
- The `~i` sigil converts to integer values, while `~I` provides fractional results.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `interval_sigil` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:interval_sigil, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/interval_sigil>.

