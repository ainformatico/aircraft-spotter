# Aircraftspotter

Project to collect and visualize data collected from a ADS-B source.

The main goal of this project is to play around with the different features of Elixir.

If you are looking for a nice interface with a Map to show you in real time where each plane is located then this might not be your project.
For those maps please refer to your local `dump-1090`.


## Umbrella projects

The current flow:

### Aircraft
Phoenix project in charge of parsing and visualizing the collected data. Data comes from the `Fetcher` application.

### Decoder
Library to help decoding ADS-B data.
The majority of the code has been ported from [dump1090](https://github.com/flightaware/dump1090).

### Fetcher
Fetches the data from a [dump1090-fa](https://github.com/flightaware/dump1090/blob/master/README-json.md) source
and makes it available via [GenStage](https://hexdocs.pm/gen_stage/GenStage.html).

The data is being collected by polling the public endpoint. For real time data we would need to listen to the TCP port from `dump1090`
and unfortunately we would need to decode all the ADS-B data again.

## Requirements

* Elixir >= 1.7
* Postgres database

## Installation

```bash
mix deps.get

DUMP1090_JSON_ENDPOINT="http://localhost:8080/data/aircraft.json" mix phx.server
```

## Release

```bash
MIX_ENV=prod mix release
```

Define the environment vars located at `rel/config/config.exs`

## Tests

```
mix test
```

## Development tools

* `mix dialyzer`
* `mix credo --verbose`
* `mix test --cover`
