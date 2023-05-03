// swift-tools-version: 5.4


import PackageDescription

let package = Package(
	name: "SwiftHamcrestAutolayoutMatchers",
	platforms: [
		.iOS(.v14),
	],
	products: [
		.library(name: "SwiftHamcrestAutolayoutMatchers", targets: ["SwiftHamcrestAutolayoutMatchers"]),
	],
	dependencies: [
		.package(url: "https://github.com/renep/SwiftHamcrest", .branch("master")),
		.package(url: "https://github.com/openbakery/PinLayout", .branch("main")),
	],
	targets: [
		.target(
			name: "SwiftHamcrestAutolayoutMatchers",
			dependencies: [
				.product(name: "Hamcrest", package: "SwiftHamcrest"),
			],
			path: "Matchers",
			sources: [
				"Main/Source"
			]
		),
		.testTarget(
			name: "SwiftHamcrestAutolayoutMatchersTest",
			dependencies: [
				"SwiftHamcrestAutolayoutMatchers",
				"PinLayout"
			],
			path: "Matchers",
			sources: [
				"Test/Source"
			]
		),
	]
)
