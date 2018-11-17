use Mix.Config

config :fetcher, dump1090_json_endpoint: System.get_env("DUMP1090_JSON_ENDPOINT")

config :aircraft, AircraftWeb.Endpoint,
  url: [host: System.get_env("HOSTNAME"), port: 80],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :aircraft, Aircraft.Repo,
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_HOST")
