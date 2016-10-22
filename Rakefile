def supported_test_targets
  return [:ios, :osx, :tvos]
end

def settings_for_platform(platform)
  if platform == :ios
    return {
      sdk: 'iphonesimulator9.1',
      scheme: 'Ogra-iOS',
      device_host: "OS='9.1',name='iPhone 6s'"
    }
  elsif platform == :osx
    return {
      sdk: 'macosx10.11',
      scheme: 'Ogra-Mac',
      device_host: "arch='x86_64'"
    }
  elsif platform == :tvos
    return {
      sdk: 'appletvsimulator9.0',
      scheme: 'Ogra-tvOS',
      device_host: "OS='9.0',name='Apple TV 1080p'"
    }
  else
    abort "You have to specify a supported platform: :ios, :osx, :tvos"
  end
end

def run_tests(platform, xcprety_args: '--test')
  project = 'Ogra.xcodeproj'
  configuration = 'Debug'
  settings = settings_for_platform platform
  sdk = settings[:sdk]
  scheme = settings[:scheme]
  destination = settings[:device_host]
  tasks = 'build test'

  sh "set -o pipefail && xcodebuild -project '#{project}' -scheme '#{scheme}' -configuration '#{configuration}' -sdk #{sdk} -destination #{destination} #{tasks} | xcpretty -c #{xcprety_args}"
end

desc 'Build, then run tests.'
task :test do
  supported_test_targets.map { |platform| run_tests platform }
end
