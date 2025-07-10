# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "geokit_aws_geoplaces"
  spec.version       = "0.0.1"
  spec.authors       = ["Adam Anderson"]
  spec.email         = ["adam@makeascene.com"]
  spec.summary       = %q{Geokit custom geocoder for AWS GeoPlaces service}
  spec.description   = %q{Geokit custom geocoder for AWS GeoPlaces service}
  spec.homepage      = "https://github.com/adamtao/geokit_aws_geoplaces.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "geokit"
  spec.add_dependency "aws-sdk-geoplaces"

end