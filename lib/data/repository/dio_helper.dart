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
      RequestTypeEnum requestType,
      {bool needAppCode = false}
      ) async {
    if (needToken) {

      AccessUser? user = await SharedPreferencesOperator.getCurrentUser();
      String token = '';
      if(user!= null){
        token = user.accessToken;
      }

      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    if(needAppCode){
      dio.options.headers['App-Code'] = "\$2a\$10\$nWXXOW327cBe1dS3b1lNqOMpHTwcl78TMPClfukxNlhodQZmAoHdm";
    }

    dio.options.headers['Accessible-Page'] = 'ClientDetail';

    try{
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
      }else {
        return null;
      }
    }catch(e){
      if(e is DioException){
        CustomException customException = CustomException.fromDioException(e);

        if(customException.code == '401'){
          //TODO CALL REFRESH TOKEN FUNCTION
        }else {
          rethrow;
        }
      }
    }
  }
}

enum RequestTypeEnum { get, post, put, delete, patch, head}
