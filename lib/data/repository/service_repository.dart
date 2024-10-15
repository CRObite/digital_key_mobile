import 'package:flutter/material.dart';
import '../../config/app_endpoints.dart';
import '../../domain/pageable.dart';
import 'dio_helper.dart';

class ServiceRepository{
  Future<Pageable?> getTransactions(BuildContext context,int page,int size,String query) async {

    String url = AppEndpoints.getAllService;

    var param = {
      "page": page,
      "size": size,
      "query": query,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get,parameters: param);

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }
}