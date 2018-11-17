defmodule Aircraftspotter.MixProject do
  use Mix.Project

  def project do
    [
      app: :aircraft_spotter,
      version: "0.0.1",
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: []
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [{:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false}, {:distillery, "~> 2.0.12"}]
  end
end
