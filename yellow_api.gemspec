require File.expand_path('../lib/yellow_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'yellow-api-wrapper'
  gem.version     = YellowApi::VERSION
  gem.licenses    = ['MIT']
  gem.authors     = ['Ian Bishop', 'Sophie Déziel']
  gem.email       = 'courrier@sophiedeziel.com'
  gem.homepage    = 'https://github.com/sophiedeziel/yellow-api-wrapper'
  gem.summary     = "Wrapper for the YellowPages' Yellow API"
  gem.description = "Ruby wrapper for the YellowPages' Yellow API based on Ian Bishop's yellow_api gem"

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 3.4'
  gem.add_development_dependency 'simplecov', '>= 0.5.0'
  gem.add_development_dependency 'webmock', '~> 1.8.0'
  gem.add_development_dependency 'yard', '~> 0.7'
  gem.add_development_dependency 'vcr', '~> 3.0'
  gem.add_development_dependency 'pry', '~> 0.10.3'
  gem.add_runtime_dependency     'faraday_middleware', '>= 0.7.0'
  gem.add_runtime_dependency     'rash', '~> 0.4.0'
  gem.add_runtime_dependency     'uuid', '~> 2.3.5'
  gem.add_runtime_dependency     'activesupport', '>= 3.0.0'
end
