Pod::Spec.new do |s|
  s.name             = "Ogra"
  s.version          = "4.1.1"
  s.summary          = "Provides the ability to convert from a model object into an Argo JSON representation."
  s.description      = "A companion project for the Argo library that facilitates converting back from model objects into JSON"
  s.homepage         = "https://github.com/edwardaux/Ogra"
  s.license          = 'MIT'
  s.author           = "Craig Edwards"
  s.source           = { :git => "https://github.com/edwardaux/Ogra.git", :tag => "#{s.version.to_s}" }

  s.dependency 'Argo', '~> 4.1.1'
  s.source_files = 'Sources/**/*.{h,swift}'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
end
