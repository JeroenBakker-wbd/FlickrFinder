# Generate report, minimum_coverage_percentage is set to 0 as it will throw an exception if not met, instead of showing the results
report = xcov.produce_report(
   scheme: 'FlickrFinder',
   configuration: 'Debug',
   derived_data_path: 'Build',
   minimum_coverage_percentage: 40.0
)

if report.coverage < 0.800
   fail("Coverage is less than 80%.")
end

# Post markdown report
xcov.output_report(report)