Pod::Spec.new do |s|
  s.name             = "Ogra"
  s.version          = "1.2"
  s.summary          = "Sync capabilities for Realm"
  s.description      = <<-DESC
                       * Markdown format.
                       DESC
  s.homepage         = "https://github.com/edwardaux/Ogra"
  s.license          = 'MIT'
  s.author           = "Craig Edwards"
  s.source           = { :git => "https://github.com/edwardaux/Ogra.git", :tag => "#{s.version.to_s}" }

  s.dependency 'Argo'
  s.source_files = 'Ogra/**/*.swift'
end
