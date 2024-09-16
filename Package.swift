// swift-tools-version: 5.4


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
		.package(url: "https://github.com/nschum/SwiftHamcrest", .branch("swift-testing")),
		.package(url: "https://github.com/openbakery/PinLayout", .branch("main"))
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
		),
		.testTarget(
			name: "HamcrestAutolayoutMatchersTest",
			dependencies: [
				"HamcrestAutolayoutMatchers",
				"PinLayout"
			],
			path: "Matchers",
			sources: [
				"Test/Source"
			]
		)
	]
)
