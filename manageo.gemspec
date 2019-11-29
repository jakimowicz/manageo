lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "manageo/version"

Gem::Specification.new do |spec|
  spec.name          = "manageo"
  spec.version       = Manageo::VERSION
  spec.authors       = ["Fabien Jakimowicz"]
  spec.email         = ["fabien@jakimowicz.com"]

  spec.summary       = %q{A lightweight Ruby client for the Plateforme mAPI from Manageo.}
  spec.description   = %q{A lightweight Ruby client for the Plateforme mAPI from Manageo.}
  spec.homepage      = "https://github.com/jakimowicz/manageo"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jakimowicz/manageo"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/jakimowicz/manageo/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'excon'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'single_cov'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'rspec_junit_formatter'

end
