import 'package:flutter/cupertino.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/domain/metric_report_group.dart';

import 'dio_helper.dart';

class MetricsRepository{

  Future<List<MetricReportGroup>> getMetrics(
      BuildContext context,
      String chartType,
      int clientId,
      {int? cabinetId,
      int? serviceId,
      String? period,
      String? startDate,
      String? endDate}
      ) async {

    String url = AppEndpoints.getMetrics;

    var param = {
      "clientId": clientId,
      "cabinetId": cabinetId,
      "serviceId": serviceId,
      "period": period,
      "chartType": chartType,
      "startDate": startDate,
      "endDate": endDate
    };

    Map<String, dynamic>? data = await DioHelper().makeRequest(context,url, true, RequestTypeEnum.get, parameters: param);

    if(data!= null){

      List<MetricReportGroup> listOfValue = [];

      for(var item in data['list']){
        listOfValue.add(MetricReportGroup.fromJson(item));
      }

      return listOfValue;
    }else {
      return [];
    }
  }
}