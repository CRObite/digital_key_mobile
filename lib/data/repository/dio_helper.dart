import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/data/repository/auth_repository.dart';
import 'package:web_com/domain/access_user.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../screens/navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../../widgets/toast_widget.dart';

class DioHelper {
  Dio dio = Dio();

  Future<Map<String, dynamic>?> makeRequest(
      BuildContext context,
      String url,
      bool needToken,

      RequestTypeEnum requestType,
      {bool needAppCode = false,
      ResponseType responseType = ResponseType.json,
      String? accessiblePage,
        Map<String, dynamic>? parameters,
        Map<String, dynamic>? body,
        FormData? fileData}
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

    if(accessiblePage != null){
      dio.options.headers['Accessible-Page'] = accessiblePage;
    }

    try{
      Response response;
      switch (requestType) {
        case RequestTypeEnum.get:
          response = await dio.get(url, queryParameters: parameters, options: Options(responseType: responseType));
          break;
        case RequestTypeEnum.post:
          response = await dio.post(url, queryParameters: parameters, data: fileData ?? body,);
          break;
        case RequestTypeEnum.put:
          response = await dio.put(url, queryParameters: parameters, data: fileData ?? body);
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

        if (responseType == ResponseType.bytes) {
          Map<String, dynamic> data = {'bytes': response.data};
          return data;
        } else {
          if(response.data == ''){
            return {'data': ''};
          }else if (response.data is List){
            return {'list': response.data as List<dynamic> };
          }

          Map<String, dynamic> data = response.data;

          return data;
        }
      } else {
        return null;
      }
    }catch(e){
      if(e is DioException){

        print(e);

        CustomException customException = CustomException.fromDioException(e);

        print(await SharedPreferencesOperator.containsCurrentUser());
        if(customException.statusCode == 401 && await SharedPreferencesOperator.containsCurrentUser()){

          AccessUser? accessUser = await SharedPreferencesOperator.getCurrentUser();

          if(accessUser!= null){


            bool value = await AuthRepository.refreshToken(context,accessUser.refreshToken);

            if(value){
               return await makeRequest(context,url, needToken, parameters:parameters, body:body, requestType);
            }else{
              context.goNamed('loginPage');
            }
          }else{
            context.goNamed('loginPage');
          }
        }else if(customException.statusCode == 403){
          final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);
          navigationPageCubit.showMessage(customException.message, false);
        }else {
          rethrow;
        }
      }else {
        rethrow;
      }
    }
    return null;
  }
}

enum RequestTypeEnum { get, post, put, delete, patch, head}
