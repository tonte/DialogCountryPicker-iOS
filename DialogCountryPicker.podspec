Pod::Spec.new do |spec|
  spec.name = "DialogCountryPicker"
  spec.version = "1.0.0"
  spec.summary = "Easy to use country picker"
  spec.homepage = "https://github.com/tonte/DialogCountryPicker-iOS"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Tonte Owuso" => 'tonteowuso@gmail.com' }
  spec.social_media_url = "http://twitter.com/t0nte"
  spec.swift_version = "4.0"
  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/tonte/DialogCountryPicker-iOS.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "DialogCountryPicker/**/*.{h,swift}"
end