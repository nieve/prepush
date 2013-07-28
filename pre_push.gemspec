# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pre_push/version'

Gem::Specification.new do |spec|
  spec.name          = "pre_push"
  spec.version       = PrePush::VERSION
  spec.authors       = ["nieve"]
  spec.email         = ["nievegoor@gmail.com"]
  spec.description   = %q{adding a pre-push hook for git to compile & run tests}
  spec.summary       = %q{Add a pre-push git hook on any of your repos to build & run tests of your .net project.}
  spec.homepage      = "https://github.com/nieve/prepush"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.post_install_message = "cd to your git repository (containing the .git directory) and from there type 'prepush' to drop the prush hook into .git/hooks. \nBy default the hook will use 'C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe' to build your solutions. Use 'prepush-config path/to/your/msbuild.exe' to modify this. \nFor more information please see https://github.com/nieve/prepush"
end
