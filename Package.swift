// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "cxxrandomx",
    platforms:[
		.macOS(.v13)
	],
    products: [
        .library(
            name: "cxxrandomx",
            targets: ["cxxrandomx"]
        ),
    ],
    targets: [
        .target(
            name: "cxxrandomx",
			exclude:[],
			publicHeadersPath:"."        
        ),
		.executableTarget(
			name:"tests",
			dependencies:[
				"cxxrandomx"
			],
			exclude:[],
			sources:["sources"],
			publicHeadersPath:"sources"
		),
//		.executableTarget(
//			name:"benchmark",
//			dependencies:[
//				"cxxrandomx"
//			],
//			exclude:[]
//		),
    ],
	cxxLanguageStandard:.cxx14
)
