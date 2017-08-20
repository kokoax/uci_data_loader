# UciDataLoader

[![hex.pm version](https://img.shields.io/hexpm/v/uci_data_loader.svg)](https://hex.pm/packages/uci_data_loader)

# Attention!
This repository load data with HTTP communication! So, Do not load data in a short time!

## Usage
- ``iex> UCIDataLoader.load_iris``
- ``iex> UCIDataLoader.load_wine_quality``

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `uci_data_loader` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:uci_data_loader, "~> 0.1.6"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/uci_data_loader](https://hexdocs.pm/uci_data_loader).

