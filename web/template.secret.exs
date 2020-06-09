use Mix.Config

config :pleroma, Pleroma.Web.Endpoint,
   url:             [host: System.get_env("PLEROMA_ENDPOINT_HOST"), scheme: System.get_env("PLEROMA_ENDPOINT_SCHEME"), port: System.get_env("PLEROMA_ENDPOINT_PORT")],
   http:            [ip: {0, 0, 0, 0}, port: 4000],
   secret_key_base: System.get_env("PLEROMA_SECRET_KEY_BASE"), signing_salt: System.get_env("PLEROMA_SIGNING_SALT")

config :pleroma, :instance,
  name:               System.get_env("PLEROMA_INSTANCE_NAME"),
  email:              System.get_env("PLEROMA_INSTANCE_EMAIL"),
  notify_email:       System.get_env("PLEROMA_INSTANCE_NOTIFY_EMAIL"),
  limit:              5000,
  registrations_open: false

config :pleroma, :media_proxy,
  enabled:             false,
  redirect_on_failure: true

config :pleroma, Pleroma.Repo,
  adapter:   Ecto.Adapters.Postgres,
  username:  System.get_env("DB_USER"),
  password:  System.get_env("DB_PASSWORD"),
  database:  System.get_env("DB_NAME"),
  hostname:  System.get_env("DB_HOST"),
  pool_size: 30

config :pleroma, :chat,     enabled: false
config :pleroma, :database, rum_enabled: false
config :pleroma, :instance, static_dir: "instance/static/"

config :pleroma, configurable_from_database: false

config :web_push_encryption, :vapid_details,
  subject:     System.get_env("PLEROMA_WEB_PUSH_SUBJECT"),
  public_key:  System.get_env("PLEROMA_WEB_PUSH_PUBLIC_KEY"),
  private_key: System.get_env("PLEROMA_WEB_PUSH_PRIVATE_KEY")

config :pleroma, Pleroma.Uploaders.S3,
  bucket:          System.get_env("S3_BUCKET"),
  public_endpoint: System.get_env("S3_PUBLIC_ENDPOINT")

config :ex_aws, :s3,
  access_key_id:     System.get_env("S3_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("S3_SECRET_ACCESS_KEY_ID"),
  region:            System.get_env("S3_REGION"),
  scheme:            "https://"

case System.get_env("PLEROMA_UPLOADER") do
  "Local" ->
    config :pleroma, Pleroma.Upload,
      uploader: Pleroma.Uploaders.Local
  "S3" ->
    config :pleroma, Pleroma.Upload,
      uploader:   Pleroma.Uploaders.S3,
      strip_exif: false
  _ ->
    config :pleroma, Pleroma.Upload,
      uploader: Pleroma.Uploaders.Local
end

config :joken, default_signer: System.get_env("JOKEN_DEFAULT_SIGNER")
