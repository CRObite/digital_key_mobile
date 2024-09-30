import 'package:flutter/material.dart';
import 'package:web_com/domain/client.dart';

import '../../config/app_endpoints.dart';
import 'dio_helper.dart';

class ClientRepository{

  static Future<Client?> getClient(BuildContext context) async {

    String url = AppEndpoints.clientMe;

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, accessiblePage: 'ClientDetail');

    if(data!= null){
      Client client =  Client.fromJson(data['content']);

      return client;
    }else {
      return null;
    }
  }

  static Future<bool> setDraft(BuildContext context, Client client) async {

    String url = AppEndpoints.clientDraft;

    Map<String, dynamic> body = client.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body, RequestTypeEnum.post, accessiblePage: 'ClientDetail' );

    if(data!= null){
      return true;
    }else {
      return false;
    }

  }


  static Future<bool> setClientChanges(BuildContext context,Client client) async {
    String url = AppEndpoints.clientSaveChanges;

    Map<String, dynamic> body = client.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body, RequestTypeEnum.put, accessiblePage: 'ClientDetail');

    if(data!= null){
      return true;
    }else {
      return false;
    }

  }

}