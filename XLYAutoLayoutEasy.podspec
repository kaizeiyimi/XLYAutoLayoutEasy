Pod::Spec.new do |s|
  s.name         = "XLYAutoLayoutEasy"
  s.version      = "2.0.0"
  s.summary      = "A powerfull wrap library which makes writing AutoLayout in code easy."
  
  s.description  = <<-DESC
                  simplify writing AutoLayout in code. provides make, update helper methods.
                  you can now handle language direction with make and update.
                   DESC

  s.homepage     = "https://github.com/kaizeiyimi/XLYAutoLayoutEasy"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "kaizei" => "kaizeiyimi@126.com" }

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/kaizeiyimi/XLYAutoLayoutEasy.git", :tag => 'v2.0.0' }
  s.source_files  = "codes/**/*.{h,m}"

  s.requires_arc = true

end
