// swift-tools-version: 5.9
import PackageDescription

#if arch(x86_64)
// this is an x86 build so we can exclude the arm64 files
let excludesList:[String] = [
	"jit_compiler_a64.hpp",
	"jit_compiler_a64.cpp",
	"jit_compiler_a64_static.hpp",
	"jit_compiler_a64_static.S"
]
#elseif arch(arm64)
// this is an arm64 build so we can exclude the x86 files
let excludesList:[String] = [

	"jit_compiler_x64.hpp",
	"jit_compiler_x64.cpp",
	"jit_compiler_x64_static.hpp",
	"jit_compiler_x64_static.S"
]
#else
fatalError("this architecture is not supported")
#endif

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
			exclude:excludesList,
			publicHeadersPath:".",
			cSettings: [
				.unsafeFlags(["-maes"])
			],
			cxxSettings:[
				.unsafeFlags(["-maes"])
			],
			linkerSettings: [
				.linkedLibrary("m"), // needed to do math
			]
        ),
		.executableTarget(
			name:"tests",
			dependencies:[
				"cxxrandomx"
			],
			exclude:[],
			cSettings: [
				.unsafeFlags(["-maes"])
			],
			cxxSettings:[
				.unsafeFlags(["-maes"])
			]
		),
		.executableTarget(
			name:"benchmark",
			dependencies:[
				"cxxrandomx"
			],
			exclude:[]
		),
    ],
	cLanguageStandard:.c17,
	cxxLanguageStandard:.cxx14
)
