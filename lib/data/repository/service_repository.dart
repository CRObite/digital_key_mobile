import 'package:flutter/material.dart';
import '../../config/app_endpoints.dart';
import '../../domain/pageable.dart';
import 'dio_helper.dart';

class ServiceRepository{
  Future<Pageable?> getAllService(BuildContext context,int page,int size,String query) async {

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

  Future<Pageable?> getAllOperations(BuildContext context,int page,int size,String status,int? clientId,String? type,{String? query,int? cabinetId}) async {

    String url = AppEndpoints.getAllServiceOperation;

    var param = {
      "page": page,
      "size": size,
      "status": status,
      "query": query,
      "clientId": clientId,
      "operationType": type,
      "cabinetId": cabinetId,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get,parameters: param,accessiblePage: 'SERVICE_OPERATION');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }

}