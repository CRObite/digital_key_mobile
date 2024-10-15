import 'package:flutter/material.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/domain/invoice.dart';
import 'package:web_com/domain/pageable.dart';

import 'dio_helper.dart';

class DocumentsRepository{
  static Future<Pageable?> getInvoices(BuildContext context,int page, int size,int clientId) async {

    String url = AppEndpoints.getInvoices;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param,accessiblePage: 'InvoiceList');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }

  static Future<Pageable?> getElectronicInvoices(BuildContext context,int page, int size,int clientId) async {

    String url = AppEndpoints.getElectronicInvoices;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param,accessiblePage: 'ESFList');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }

  static Future<Pageable?> getCompletionActs(BuildContext context, int page, int size,int clientId) async {

    String url = AppEndpoints.getCompletionActs;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
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