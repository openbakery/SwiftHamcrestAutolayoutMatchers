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
		.package(url: "https://github.com/nschum/SwiftHamcrest/", .upToNextMajor(from: "2.3.0")),
		.package(url: "https://github.com/openbakery/PinLayout", .branch("main")),
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
				"PinLayout",
				.product(name: "HamcrestSwiftTesting", package: "SwiftHamcrest"),
			],
			path: "Matchers",
			sources: [
				"Test/Source"
			]
		),
	]
)
