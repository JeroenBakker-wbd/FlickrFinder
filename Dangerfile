# Generate report
report = xcov.produce_report(
   scheme: 'FlickrFinder',
   configuration: 'Debug',
   derived_data_path: 'Build',
   minimum_coverage_percentage: 80.0
)

# Post markdown report
xcov.output_report(report)