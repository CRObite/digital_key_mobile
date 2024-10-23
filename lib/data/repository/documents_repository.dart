import 'package:flutter/material.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/domain/invoice.dart';
import 'package:web_com/domain/pageable.dart';

import 'dio_helper.dart';

class DocumentsRepository{
  static Future<Pageable?> getInvoices(BuildContext context,int page, int size,int clientId,{String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) async {

    String url = AppEndpoints.getInvoices;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
      "amountMin": fromAmount,
      "amountMax": toAmount,
      "status": status,
      "startAt": fromDate,
      "endAt": toDate,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param,accessiblePage: 'InvoiceList');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }

  static Future<Pageable?> getElectronicInvoices(BuildContext context,int page, int size,int clientId,{String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) async {

    String url = AppEndpoints.getElectronicInvoices;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
      "amountMin": fromAmount,
      "amountMax": toAmount,
      "status": status,
      "startAt": fromDate,
      "endAt": toDate,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param,accessiblePage: 'ESFList');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }

  static Future<Pageable?> getCompletionActs(BuildContext context, int page, int size,int clientId,{String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) async {

    String url = AppEndpoints.getCompletionActs;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
      "amountMin": fromAmount,
      "amountMax": toAmount,
      "status": status,
      "startAt": fromDate,
      "endAt": toDate,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param, accessiblePage: 'AVRList');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }
}