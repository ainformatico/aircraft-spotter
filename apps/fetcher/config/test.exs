use Mix.Config

config :fetcher, dump1090_json_endpoint: "/data.json"
config :fetcher, api: Fetcher.ApiMock

config :fetcher, worker: Fetcher.WorkerMock
config :fetcher, parser: Fetcher.ParserMock

config :fetcher, schedule: false
