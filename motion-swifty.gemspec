# -*- encoding: utf-8 -*-
module ::Motion; module Project; class Config
  def self.variable(*); end
end; end; end

VERSION = "0.1.0"

Gem::Specification.new do |spec|
  spec.name          = "motion-swifty"
  spec.version       = VERSION
  spec.authors       = ["Joffrey JAFFEUX", "Mark VILLACAMPA"]
  spec.email         = ["j.jaffeux@gmail.com"]
  spec.description   = %q{Swift dependencies in RubyMotion}
  spec.summary       = %q{A simple and clean way to use Swift dependencies in your RubyMotion project.y}
  spec.homepage      = "https://github.com/jjaffeux/swifty"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
