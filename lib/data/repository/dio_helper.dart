import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/domain/access_user.dart';
import 'package:web_com/utils/custom_exeption.dart';

class DioHelper {
  Dio dio = Dio();

  Future<Map<String, dynamic>?> makeRequest(
      String url,
      bool needToken,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? body,
      RequestTypeEnum requestType) async {
    if (needToken) {

      String? data = await SharedPreferencesOperator.getCurrentUser();
      String token = '';
      if(data!= null){
        AccessUser user = AccessUser.fromJson(jsonDecode(data));
        token = user.accessToken;
      }

      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    Response response;
    switch (requestType) {
      case RequestTypeEnum.get:
        response = await dio.get(url, queryParameters: parameters);
        break;
      case RequestTypeEnum.post:
        response = await dio.post(url, queryParameters: parameters, data: body);
        break;
      case RequestTypeEnum.put:
        response = await dio.put(url, queryParameters: parameters, data: body);
        break;
      case RequestTypeEnum.delete:
        response = await dio.delete(url, queryParameters: parameters, data: body);
        break;
      case RequestTypeEnum.patch:
        response = await dio.patch(url, queryParameters: parameters, data: body);
        break;
      case RequestTypeEnum.head:
        response = await dio.head(url, queryParameters: parameters);
        break;
      default:
        throw UnsupportedError('Unsupported request type');
    }

    if (response.statusCode! ~/ 100 == 2) {

      print(response.data);

      Map<String, dynamic> data = response.data;
      return data;
    } else {
      return null;
    }
  }
}

enum RequestTypeEnum { get, post, put, delete, patch, head}
