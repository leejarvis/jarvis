import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jarvis, JarvisWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Cq8J+34aOogAVPVgglF+Qt04Vya2elMhvv3EGL2+GoonBPkY+aBCc91YFn/v3mEr",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
