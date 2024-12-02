defmodule IntervalSigil.MixProject do
  use Mix.Project

  @github_url "https://github.com/whitered/interval_sigil"

  def project do
    [
      app: :interval_sigil,
      version: "0.1.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: @github_url
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Interval sigils and conversion utilities"
  end

  defp package do
    [
      maintainers: ["Dmitry Zhelnin"],
      licenses: ["MIT"],
      links: %{"GitHub" => @github_url}
    ]
  end
end
