import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cool_blogger, CoolBloggerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "kfxDlxXzQreCbNeQ9w7wez1gJ03/X/qkhpXYNsfl7CxqACxxSyK3uQ0XyY12td32",
  server: false

# In test we don't send emails.
config :cool_blogger, CoolBlogger.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
