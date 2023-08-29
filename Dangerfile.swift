import DangerSwiftCoverage

Coverage.xcodeBuildCoverage(
    .derivedDataFolder("Build"), 
    minimumCoverage: 80
)
