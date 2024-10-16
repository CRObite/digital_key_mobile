
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/data/repository/metrics_repository.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/domain/metric_report_group.dart';

import '../../../../../domain/client.dart';
import '../../../../../domain/service.dart';
import '../../../../../utils/custom_exeption.dart';
import '../../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticInitial());

  List<Service> serviceList = [];



  Future<void> getChartData(BuildContext context, NavigationPageCubit navigationPageCubit,String chartType,String period,{bool saveService = false,String? startDate,String? endDate, int? cabinetId, int? serviceId }) async {
    try{

      emit(StatisticLoading());

      Client? client = await ClientRepository.getClient(context);

      if(client!= null){

        List<MetricReportGroup> metricReportGroup = await MetricsRepository().getMetrics(context, chartType, client.id!, period: period,startDate: startDate,endDate: endDate,serviceId: serviceId,cabinetId: cabinetId);

        if(saveService){
          serviceList.clear();

          for(var metricReport in metricReportGroup){
            if(metricReport.content!= null){
              for(var content in metricReport.content!){
                if((!serviceList.contains(content.resource?.service)) && content.resource?.service != null){
                  serviceList.add(content.resource!.service!);
                }
              }
            }
          }
        }

        emit(StatisticFetingSuccess(metricReportGroupList: metricReportGroup));

      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);

        emit(StatisticFetingSuccess(metricReportGroupList: const []));
      }else{
        rethrow;
      }
    }
  }
}
