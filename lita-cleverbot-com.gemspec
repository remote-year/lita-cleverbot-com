Gem::Specification.new do |spec|
  spec.name          = "lita-cleverbot-com"
  spec.version       = "0.1.0"
  spec.authors       = ["Matthew Walters"]
  spec.email         = ["matthew.walters@remoteyear.com"]
  spec.description   = "A cleverbot.com integration for unhandled messages"
  spec.summary       = "Makes Lita seem more alive"
  spec.homepage      = "htpp://remoteyear.com"
  spec.license       = "its free like speech... but beer too"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
