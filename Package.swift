// swift-tools-version:5.7
import PackageDescription


let swiftSettings: [SwiftSetting] = []
//let swiftSettings: [SwiftSetting] = [.unsafeFlags(["-Xfrontend", "-warn-concurrency", "-Xfrontend", "-enable-actor-data-race-checks"])]

let package = Package(
	name: "AppleDeviceIdentificator",
	products: [
		.library(name: "AppleDeviceIdentificator", targets: ["AppleDeviceIdentificator"])
	],
	targets: [
		.target(name: "AppleDeviceIdentificator", path: "Sources", swiftSettings: swiftSettings)
	]
)
