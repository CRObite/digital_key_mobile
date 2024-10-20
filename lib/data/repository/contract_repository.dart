import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_com/domain/pageable.dart';

import '../../config/app_endpoints.dart';
import '../../domain/contract.dart';
import 'dio_helper.dart';

class ContractRepository{

  static Future<Pageable?> getContractsByClientId(BuildContext context,int clientId,int page,int size) async {

    String url = AppEndpoints.getAllContracts;

    Map<String, dynamic> param = {
      "clientId": clientId,
      "page": page,
      "size": size,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, parameters: param, RequestTypeEnum.get,accessiblePage: 'ContractDetail');

    if(data!= null){

      Pageable pageable = Pageable.fromJson(data);

      return pageable;
    }else {
      return null;
    }
  }

  static Future<bool> createContract(BuildContext context,Contract contract) async {

    String url = AppEndpoints.createContract;

    Map<String, dynamic> body = contract.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body, RequestTypeEnum.post,accessiblePage: 'ContractDetail');

    if(data!= null){
      return true;
    }else {
      return false;
    }
  }

  static Future<bool> createDraftContract(BuildContext context,Contract contract) async {

    String url = AppEndpoints.createGraftContract;

    Map<String, dynamic> body = contract.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body, RequestTypeEnum.post,accessiblePage: 'ContractDetail');

    if(data!= null){
      return true;
    }else {
      return false;
    }
  }


  static Future<Pageable?> getContractService(BuildContext context,String query,int page,int size, {int? clientId,int? serviceId, } ) async {

    String url = AppEndpoints.getContractService;

    Map<String, dynamic> param = {
      'criteria': {
        "query": query,
        "clientId": clientId,
        "serviceId" : serviceId
      },
      'pageable': {
        "page": page,
        "size": size,
      }
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, parameters: param, RequestTypeEnum.get);

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }

}