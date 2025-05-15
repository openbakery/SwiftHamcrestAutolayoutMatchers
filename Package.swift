// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "HamcrestAutolayoutMatchers",
	platforms: [
		.iOS(.v14)
	],
	products: [
		.library(name: "HamcrestAutolayoutMatchers", targets: ["HamcrestAutolayoutMatchers"])
	],
	dependencies: [
		.package(url: "https://github.com/nschum/SwiftHamcrest/", from: "2.3.0")
	],
	targets: [
		.target(
			name: "HamcrestAutolayoutMatchers",
			dependencies: [
				.product(name: "Hamcrest", package: "SwiftHamcrest")
			],
			path: "Matchers",
			sources: [
				"Main/Source"
			]
		)
	]
)
