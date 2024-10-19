
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/data/repository/metrics_repository.dart';
import 'package:web_com/domain/metric_report_group.dart';

import '../../../../../domain/client.dart';
import '../../../../../domain/client_contract_service.dart';
import '../../../../../domain/service.dart';
import '../../../../../utils/custom_exeption.dart';
import '../../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticInitial());

  List<Service> serviceList = [];



  Future<void> getChartData(BuildContext context, NavigationPageCubit navigationPageCubit,String chartType,{bool saveService = false, bool needFullLoading = false}) async {
    try{

      if(needFullLoading){
        emit(StatisticLoading());
      }else{
        emit(StatisticChartLoading());
      }


      Client? client = await ClientRepository.getClient(context);

      if(client!= null){

        List<MetricReportGroup> metricReportGroup = await MetricsRepository().getMetrics(
            context,
            chartType,
            client.id!,
            period: getPeriod(),
            startDate: selectedDateRange != null ?  DateFormat('yyyy-MM-dd').format(selectedDateRange!.start): null,
            endDate: selectedDateRange != null ?  DateFormat('yyyy-MM-dd').format(selectedDateRange!.end): null,
            serviceId: serviceId,
            cabinetId: cabinetId
        );

        if(saveService){
          serviceList.clear();

          for(var metricReport in metricReportGroup){
            if(metricReport.content!= null){
              for(var content in metricReport.content!){
                if(content.resource?.service == null) continue;
                if(!serviceList.map((e) => e.name).toList().contains(content.resource?.service?.name)){
                  serviceList.add(content.resource!.service!);
                }
              }
            }
          }
        }

        emit(StatisticFetingSuccess(metricReportGroupList: metricReportGroup, chartValues: onMetricSelected(metricReportGroup, 'impressions')));
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);

        emit(StatisticFetingSuccess(metricReportGroupList: const [], chartValues: const {}));
      }else{
        rethrow;
      }
    }
  }


  void metricsChanged(List<MetricReportGroup> metricReportGroupList, String key){

    emit(StatisticChartLoading());

    emit(StatisticFetingSuccess(metricReportGroupList: metricReportGroupList, chartValues: onMetricSelected(metricReportGroupList, key)));
  }

  Map<String,double?> onMetricSelected(List<MetricReportGroup> metricReportGroupList, String key){
    Map<String,double?> values = {};

    if(metricReportGroupList.isNotEmpty){
      if(metricReportGroupList.first.content != null){
        for(var item in metricReportGroupList.first.content!){
          if(item.resource!.resourceName != null){
            values[item.resource!.resourceName!] = item.metrics!.toJson()[key];
          }
        }
      }
    }

    return values;
  }




  //Pie Chart
  int currentPosition = 1;


  int? cabinetId;
  ClientContractService? cabinet;
  int? serviceId;
  dynamic service;
  DateTimeRange? selectedDateRange;

  Color getColor(int index, int totalSections) {
    final hue = 180 + (index * 60 / totalSections) % 60;
    return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
  }

  String getPeriod() {
    switch(currentPosition){
      case 0:
        return 'DAY';
      case 1:
        return 'WEEK';
      case 2:
        return 'MONTH';
      default:
        return '';
    }
  }

  Future<void> selectDateRange(BuildContext context,NavigationPageCubit navigationPageCubit) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange,
    );
    if (picked != null && picked != selectedDateRange) {
      selectedDateRange = picked;
      getChartData(context, navigationPageCubit, 'DONUT',);
    }
  }

  Future<void> resetValues(BuildContext context,NavigationPageCubit navigationPageCubit) async {
    cabinetId = null;
    cabinet = null;
    serviceId = null;
    service = null;
    selectedDateRange = null;
    getChartData(context,navigationPageCubit, 'DONUT', saveService: true,needFullLoading: true);
  }

  Future<void> changePosition(BuildContext context,NavigationPageCubit navigationPageCubit, int position, String type) async {
    currentPosition = position;
    getChartData(context,navigationPageCubit, type);
  }

}
