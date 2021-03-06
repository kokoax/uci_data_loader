defmodule UciDataLoader.Mixfile do
  use Mix.Project

  def project do
    [app: :uci_data_loader,
     version: "0.1.7",
     elixir: "~> 1.5",
     description: "Load data from UCI repository",
     package: [
       maintainers: ["kokoax"],
       licenses: ["MIT"],
       links: %{
         "UCIDataLoader" => "https://github.com/kokoax/uci_data_loader",
         "HTTPoison" => "https://github.com/edgurgel/httpoison",
       }
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.1.0", only: :dev},
      {:httpoison, "~> 0.11.1"},
    ]
  end
end
