Pod::Spec.new do |s|
  s.name         = "SSRouter"
  s.version      = "1.0"
  s.summary      = "Modular development artifact."
  s.homepage     = "https://github.com/yoonthinker"
  s.license      = "MIT"
  s.author       = { "尹思同" => "yoonthinker@gmail.com" }
  s.source       = { :git => "https://github.com/yoonthinker/SSRouter", :tag => s.version}
  s.source_files = "SSRouter/*"
  #s.resources    = ''
  s.requires_arc = true
  s.platform     = :ios, '8.0'

end
