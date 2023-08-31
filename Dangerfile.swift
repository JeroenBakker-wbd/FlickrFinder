import Danger
import DangerSwiftCoverage
//import DangerXCodeSummary

let danger = Danger()

//let report = XCodeSummary(filePath: "result.json")
//report.report()

//Coverage.xcodeBuildCoverage(.derivedDataFolder("Build"), minimumCoverage: 50)

let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("These files have changed: \(editedFiles.joined(separator: ", "))")