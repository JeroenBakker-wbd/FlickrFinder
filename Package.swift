// swift-tools-version:5.7
 import PackageDescription

 let package = Package(
     name: "DangerDependencies",
     products: [
       .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"])
     ],
     dependencies: [
         .package(url: "https://github.com/f-meloni/danger-swift-coverage", from: "0.1.0"),
         //.package(url: "https://github.com/f-meloni/danger-swift-xcodesummary", from: "1.0.0"),
     ],
     targets: [
         .target(
             name: "DangerDependencies",
             dependencies: [
                 .product(name: "DangerSwiftCoverage", package: "danger-swift-coverage"),
                 //.product(name: "DangerXCodeSummary", package: "danger-swift-xcodesummary")
             ],
             path: "DangerDependencies",
             sources: ["DangerProxy.swift"]
         )
     ]
 )
