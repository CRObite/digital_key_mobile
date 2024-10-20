
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/data/repository/metrics_repository.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/linear_metrics.dart';
import 'package:web_com/domain/metric_report_group.dart';

import '../../../../../domain/client.dart';
import '../../../../../domain/client_contract_service.dart';
import '../../../../../domain/service.dart';
import '../../../../../utils/custom_exeption.dart';
import '../../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../line_chart_part.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticInitial());

  List<Service> serviceList = [];
  List<ClientContractService> clientContractServiceList = [];

  int? clientId;

  List<String> firstMetrics = ['impressions','conversions','clicks','cost' ];

  Future<void> getChartData(BuildContext context, NavigationPageCubit navigationPageCubit,String chartType,{bool saveService = false, bool needFullLoading = false, bool saveCabinet = false}) async {
    try{

      if(needFullLoading){
        emit(StatisticLoading());
      }else{
        emit(StatisticChartLoading());
      }


      Client? client = await ClientRepository.getClient(context);

      if(client!= null){
        clientId =  client.id!;
        List<MetricReportGroup> metricReportGroup = await MetricsRepository().getMetrics(
            context,
            chartType,
            client.id!,
            period: getPeriod(),
            startDate: selectedDateRange != null ?  DateFormat('yyyy-MM-dd').format(selectedDateRange!.start): null,
            endDate: selectedDateRange != null ?  DateFormat('yyyy-MM-dd').format(selectedDateRange!.end): null,
            serviceId: serviceId,
            cabinetId: cabinetId,
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

          if(chartType == 'LINE'){
            service = serviceList.first;
            serviceId = serviceList.first.id;

            getChartData(context, navigationPageCubit, 'LINE',saveCabinet: true);
            return;
          }
        }

        if(saveCabinet){
          clientContractServiceList.clear();

          for(var metricReport in metricReportGroup){
            if(metricReport.content!= null){
              for(var content in metricReport.content!){
                if(content.resource?.clientContractService == null) continue;
                if(!clientContractServiceList.map((e) => e.name).toList().contains(content.resource?.clientContractService?.name)){
                  clientContractServiceList.add(content.resource!.clientContractService!);
                }
              }
            }
          }

          print(clientContractServiceList);
        }


        if(chartType == 'LINE'){


          for(int i=0; i<listOfMetricValue.length; i++){
            setLineAxis(i, onLinearMetricSelected(metricReportGroup, firstMetrics[i]));
          }

          emit(StatisticLineFetingSuccess(
              metricReportGroupList: metricReportGroup,
              lineChartValues: [
                onLinearMetricSelected(metricReportGroup, firstMetrics[0]),
                onLinearMetricSelected(metricReportGroup, firstMetrics[1]),
                onLinearMetricSelected(metricReportGroup, firstMetrics[2]),
                onLinearMetricSelected(metricReportGroup, firstMetrics[3]),
              ]));
        }else{
          emit(StatisticFetingSuccess(metricReportGroupList: metricReportGroup, chartValues: onMetricSelected(metricReportGroup, firstMetrics[1])));
        }


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


  void metricsChanged(List<MetricReportGroup> metricReportGroupList,  String key,{int? index, List<Map<String,double?>>? lineChartValues}){

    emit(StatisticChartLoading());

    if(index!= null && lineChartValues!= null){

      lineChartValues[index] = onLinearMetricSelected(metricReportGroupList, key);

      emit(StatisticLineFetingSuccess(metricReportGroupList: metricReportGroupList, lineChartValues: lineChartValues));
    }else{
      emit(StatisticFetingSuccess(metricReportGroupList: metricReportGroupList, chartValues: onMetricSelected(metricReportGroupList, key)));
    }

  }

  Map<String,double?> onMetricSelected(List<MetricReportGroup> metricReportGroupList, String key){
    Map<String,double?> values = {};

    if(metricReportGroupList.isNotEmpty){
      if(metricReportGroupList.first.content != null){
        for(var item in metricReportGroupList.first.content!){
          if(item.resource!.resourceName != null){
            values[item.resource!.resourceName!] = item.metrics!.toJson()[key];
          }else{
            values[item.resource!.clientContractService!.name!] = item.metrics!.toJson()[key];
          }
        }
      }
    }

    return values;
  }

  Map<String,double?> onLinearMetricSelected(List<MetricReportGroup> metricReportGroupList, String key){
    Map<String,double?> values = {};

    if(metricReportGroupList.isNotEmpty){
      if(metricReportGroupList.first.content?.first != null){
        if(metricReportGroupList.first.content?.first.metrics != null){
          LinearMetrics linearMetrics = metricReportGroupList.first.content?.first.metrics;
          for(var item in linearMetrics.values){
            if(item.metric == key){
              return item.values ?? {};
            }
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
  Service? service;

  int? companyId;
  Company? company;

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

  Future<void> resetValues(BuildContext context,NavigationPageCubit navigationPageCubit,  String type) async {
    cabinetId = null;
    cabinet = null;
    serviceId = null;
    service = null;
    selectedDateRange = null;
    getChartData(context,navigationPageCubit, type, saveService: true,needFullLoading: true);
  }

  Future<void> changePosition(BuildContext context,NavigationPageCubit navigationPageCubit, int position, String type) async {
    currentPosition = position;
    getChartData(context,navigationPageCubit, type);
  }



  //line chart part



  List<bool> listOfMetricValue = [true,true,true,true];
  List<String?> titles = [];
  List<int> colors = [0xff7F6BD8,0xffDB6ACB,0xff69B8DA,0xffD1D5DB];



  void setLineAxis(int index,Map<String, double?> data){
    String? assignedYAxis;
    assignedYAxis = assignYAxis(data);

    if(listOfMetricValue[index]){
      yAxisUsage.forEach((axis, _) {
        if(assignedYAxis == axis && yAxisUsage[axis]!= null){
          yAxisUsage[axis] = yAxisUsage[axis]! + 1;
        }
      });
    }else{
      yAxisUsage.forEach((axis, _) {
        if(assignedYAxis == axis && yAxisUsage[axis]!= null){
          yAxisUsage[axis] = yAxisUsage[axis]! -1;
        }
      });
    }
  }

  Map<String, int> yAxisUsage = {
    'FirstYAxis': 0,
    'SecondaryYAxis': 0,
    'ThirdYAxis': 0,
    'FourthYAxis': 0,
  };

  String? assignYAxis(Map<String, double?> data) {
    if (data.isEmpty) return null;
    List<double> nonNullValues = data.values.where((value) => value != null).cast<double>().toList();
    if (nonNullValues.isEmpty) return null;

    double averageValue = nonNullValues.reduce((a, b) => a + b) / nonNullValues.length;

    if (averageValue <= 1000) {
      return 'FirstYAxis';
    } else if (averageValue <= 10000) {
      return 'SecondaryYAxis';
    } else if (averageValue <= 100000) {
      return 'ThirdYAxis';
    } else {
      return 'FourthYAxis';
    }
  }



  bool shouldShowAxis(String? name) {
    for(int i=0; i<titles.length; i++){
      if(titles[i] == name){
        if(listOfMetricValue[i]){
          continue;
        }else{
          return false;
        }
      }
    }

    if(titles.isEmpty){
      return false;
    }

    return true;
  }


  List<ChartData> convertData(Map<String,double?> dataMap){
    List<ChartData> chartDataList = dataMap.entries.map((entry) {
      return ChartData(
        date: DateTime.parse(entry.key),  // Convert String date to DateTime
        value: entry.value,               // Use the double? value
      );
    }).toList();

    return chartDataList;
  }

}
