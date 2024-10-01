import 'package:flutter/cupertino.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/domain/metric_report_group.dart';

import 'dio_helper.dart';

class MetricsRepository{

  Future<MetricReportGroup?> getMetrics(
      BuildContext context,
      int clientId,
      int cabinetId,
      int serviceId,
      String period,
      String chartType) async {

    String url = AppEndpoints.getMetrics;

    var param = {
      "criteria":{
        "clientId": clientId,
        "cabinetId": cabinetId,
        "serviceId": serviceId,
        "period": period,
        "chartType": chartType,
      }
    };

    Map<String, dynamic>? data = await DioHelper().makeRequest(context,url, true, RequestTypeEnum.get, parameters: param);

    if(data!= null){
      return MetricReportGroup.fromJson(data);
    }else {
      return null;
    }
  }
}