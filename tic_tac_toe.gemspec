lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "Ruby_Tic_Tac_Toe"
  spec.version       = '1.0'
  spec.license       = "MIT"

  spec.files         = ['lib/tic_tac_toe.rb']
  spec.executables   = ['bin/tic_tac_toe']
  spec.test_files    = ['spec/spec*.rb']
  spec.require_paths = ["lib"]
end