require "lita"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/cleverbot_com"

Lita::Handlers::CleverbotCom.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
