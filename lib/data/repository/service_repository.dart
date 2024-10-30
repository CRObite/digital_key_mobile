import 'package:flutter/material.dart';
import 'package:web_com/domain/service_operation.dart';
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


  Future<ServiceOperation?> createOperations(BuildContext context,ServiceOperation operation) async {

    String url = AppEndpoints.createServiceOperation;

    var body = operation.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.post,body: body);

    if(data!= null){
      return ServiceOperation.fromJson(data);
    }else {
      return null;
    }
  }

  Future<ServiceOperation?> updateOperations(BuildContext context,ServiceOperation operation) async {

    String url = AppEndpoints.updateServiceOperation;

    var body = operation.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.put,body: body);

    if(data!= null){
      return ServiceOperation.fromJson(data);
    }else {
      return null;
    }
  }

}