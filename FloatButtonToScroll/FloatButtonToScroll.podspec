Pod::Spec.new do |spec|

  spec.name         = "FloatButtonToScroll"
  spec.version      = "1.1.3"
  spec.summary      = "This is such a FloatButtonToScroll framework. Power!"
  spec.description  = "This is an amazingly Floating Button to Scroll on top or bottom framework. Add it in any view you like very easily!"
  spec.homepage     = "https://github.com/fkalai/FloatButtonToScroll"
  
  spec.license      = "MIT"

  spec.author             = { "Fotis Kalaitzidis" => "fkalaitzidis@gmaim.com" }

  spec.platform     = :ios, "10.0"
  
  spec.source       = { :git => "https://github.com/fkalai/FloatButtonToScroll.git", :tag => "1.1.3" }
  
  spec.source_files  = "FloatButtonToScroll/**/*.{h,m,swift}"
  
  spec.swift_versions = "5.0"

end
