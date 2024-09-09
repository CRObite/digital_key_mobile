import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_com/domain/pageable.dart';

import '../../domain/contract.dart';
import 'dio_helper.dart';

class ContractRepository{

  static Future<Pageable?> getContractsByClientId(BuildContext context,String url,int clientId,int page,int size) async {

    Map<String, dynamic> param = {
      "clientId": clientId,
      "page": page,
      "size": size,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, param, null, RequestTypeEnum.get,accessiblePage: 'ContractDetail');

    if(data!= null){

      Pageable pageable = Pageable.fromJson(data);

      return pageable;
    }else {
      return null;
    }
  }

  static Future<bool> createContract(BuildContext context,String url, Contract contract) async {

    Map<String, dynamic> body = contract.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, null, body, RequestTypeEnum.post,accessiblePage: 'ContractDetail');

    if(data!= null){
      return true;
    }else {
      return false;
    }
  }

}