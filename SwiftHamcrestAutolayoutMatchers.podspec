Pod::Spec.new do |spec|
	spec.name         = 'SwiftHamcrestAutolayoutMatchers'
	spec.version      = '1.0.0'
	spec.summary      = "Swift Hamcrest matcher to test autolayout constraints"
	spec.homepage     = "https://github.com/openbakery/SwiftHamcrestAutolayoutMatchers"
	spec.author       = { "René Pirringer" => "rene@openbakery.org" }
	spec.social_media_url = 'https://twitter.com/rpirringer'
	spec.source       = { :git => "https://github.com/openbakery/SwiftHamcrestAutolayoutMatchers.git", :tag => spec.version.to_s}

  spec.module_name  = "HamcrestAutolayoutMatchers"
	spec.platform = :ios
	spec.ios.deployment_target = '9.0'
	spec.license      = 'BSD'
	spec.requires_arc = true
	spec.swift_version = '5.0'	
	
	spec.dependency 'SwiftHamcrest'
	spec.ios.frameworks   = "Foundation", "Hamcrest"

	spec.source_files = "Matcher/Main/Source/Matchers/*.swift"

end
