defmodule AwsErin.MixProject do
  use Mix.Project

  def project do
    [
      app: :aws_erin,
      version: "0.4.1",
      elixir: "~> 1.9",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/imahiro-t/aws_erin",
      docs: [
        main: "readme", # The main page in the docs
        extras: ["README.md"]
      ]
    ]
  end

  defp description do
    "This library is AWS SDK."
  end

  defp package do
    [
      name: "aws_erin",
      maintainers: ["erin"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/imahiro-t/aws_erin"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:httpoison, "~> 1.6.2"},
      {:jason, "~> 1.1"},
      {:elixir_xml_to_map, "~> 0.2.0"}
    ]
  end
end
