enum MetricsReportType{
  SERVICE, CABINET, CAMPAIGN
}

MetricsReportType? metricsReportTypeFromJson(String? status) {
  return status == null? null : MetricsReportType.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? metricsReportTypeToJson(MetricsReportType? status) {
  return status?.toString().split('.').last;
}