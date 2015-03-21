# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_itc_autoingestion/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_itc_autoingestion'
  spec.version       = SlackItcAutoingestion::VERSION
  spec.authors       = ['Ian Hirschfeld']
  spec.email         = ['contact@ianhirschfeld']
  spec.summary       = %q{Slack integration with iTunes Connect.}
  spec.description   = %q{Post iTunes Connect report data to Slack.}
  spec.homepage      = ''
  # spec.homepage      = 'http://github.com/thesoapcollective/slack-itc-autoingestion'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'itunes_ingestion', '~> 0'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
end
