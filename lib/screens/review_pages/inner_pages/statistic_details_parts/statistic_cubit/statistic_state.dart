part of 'statistic_cubit.dart';

@immutable
abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticChartLoading extends StatisticState {}

class StatisticFetingSuccess extends StatisticState {
  final List<Service> serviceList;
  final List<ClientContractService> contractServiceList;
  final List<MetricReportGroup> metricReportGroupList;

  StatisticFetingSuccess({required this.serviceList, required this.contractServiceList, required this.metricReportGroupList});
}
