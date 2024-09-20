import 'package:flutter/material.dart';
import 'package:web_com/domain/client.dart';

import 'dio_helper.dart';

class ClientRepository{

  static Future<Client?> getClient(BuildContext context,String url) async {

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, accessiblePage: 'ClientDetail');

    if(data!= null){
      Client client =  Client.fromJson(data['content']);

      return client;
    }else {
      return null;
    }
  }

  static Future<bool> setDraft(BuildContext context,String url, Client client) async {

    Map<String, dynamic> body = client.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body, RequestTypeEnum.post, accessiblePage: 'ClientDetail' );

    if(data!= null){
      return true;
    }else {
      return false;
    }

  }


  static Future<bool> setClientChanges(BuildContext context,String url, Client client) async {

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