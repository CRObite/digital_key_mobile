part of 'statistic_cubit.dart';

@immutable
abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticChartLoading extends StatisticState {}

class StatisticFetingSuccess extends StatisticState {
  final List<MetricReportGroup> metricReportGroupList;
  final Map<String,double?> chartValues;
  StatisticFetingSuccess( {required this.metricReportGroupList, required this.chartValues});
}

class StatisticLineFetingSuccess extends StatisticState {
  final List<MetricReportGroup> metricReportGroupList;
  final List<Map<String,double?>> lineChartValues;

  StatisticLineFetingSuccess( {required this.metricReportGroupList, required this.lineChartValues});
}
