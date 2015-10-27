Pod::Spec.new do |s|
  s.name             = "Ogra"
  s.version          = "2.1.0"
  s.summary          = "Provides the ability to convert from a model object into an Argo JSON representation."
  s.description      = <<-DESC
                       * Markdown format.
                       DESC
  s.homepage         = "https://github.com/edwardaux/Ogra"
  s.license          = 'MIT'
  s.author           = "Craig Edwards"
  s.source           = { :git => "https://github.com/edwardaux/Ogra.git", :tag => "#{s.version.to_s}" }

  s.dependency 'Argo'
  s.source_files = 'Ogra/**/*.{h,swift}'
end
