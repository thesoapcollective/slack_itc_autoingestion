# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_itc_autoingestion/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_itc_autoingestion'
  spec.version       = SlackItcAutoingestion::VERSION
  spec.authors       = ['Ian Hirschfeld']
  spec.email         = ['ihirschfeld@thesoapcollective.com']
  spec.summary       = %q{iTunes Connect autoingestion webhook for Slack.}
  spec.description   = %q{Post iTunes Connect report data to your Slack channels.}
  spec.homepage      = 'https://github.com/thesoapcollective/slack_itc_autoingestion'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'itunes_ingestion', '~> 0'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
end
