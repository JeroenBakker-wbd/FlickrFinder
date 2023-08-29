// swift-tools-version:5.7
 import PackageDescription

 let package = Package(
     name: "FlickrFinder-PRLinter",
     defaultLocalization: "en",
     products: [
       .library(name: "DangerDeps", type: .dynamic, targets: ["FlickrFinder-PRLinter"])
     ],
     dependencies: [
         .package(url: "https://github.com/f-meloni/danger-swift-coverage", from: "0.1.0") // dev
     ],
     targets: [
         .target(
             name: "FlickrFinder-PRLinter",
             dependencies: [
                 .product(name: "DangerSwiftCoverage", package: "danger-swift-coverage")
             ],
             path: "FlickrFinder",
             sources: ["DangerProxy.swift"]
         )
     ]
 )
