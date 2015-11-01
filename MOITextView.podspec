Pod::Spec.new do |spec|
  spec.name         = 'MOITextView'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/mconintet/MOITextView'
  spec.authors      = { 'mconintet' => 'mconintet@gmail.com' }
  spec.summary      = 'Auto height and placeholder text view in Object-C for iOS'
  spec.source       = { :git => 'https://github.com/mconintet/MOITextView.git', :tag => '0.0.1' }
  spec.source_files = 'MOITextView'
  spec.ios.deployment_target = '9.0'
end