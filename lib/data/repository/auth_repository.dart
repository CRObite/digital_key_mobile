import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_com/config/app_formatter.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/domain/access_user.dart';

import '../../config/app_endpoints.dart';
import '../../domain/user.dart';
import 'dio_helper.dart';

class AuthRepository {

  static Future<bool> loginUser( BuildContext context, String login, String password) async {

    String url = AppEndpoints.login;

    Map<String, dynamic> body = {'login': login, 'password': password};
    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context, url, false,  body: body, RequestTypeEnum.post);

    if (data != null) {
      AccessUser accessUser = AccessUser.fromJson(data);

      SharedPreferencesOperator.saveCurrentUser(
          jsonEncode(accessUser.toJson()));

      return true;
    } else {
      return false;
    }
  }


  static Future<bool> loginUserByProvider( BuildContext context, String code , String? codeChallenge,String type, String platform) async {

    String url = AppEndpoints.login;

    Map<String, dynamic> body = {
      "auth_code": code,
      "provider_type": type,
      "platform": platform,
      "code_challenge": codeChallenge
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context, url, false,  body: body, RequestTypeEnum.post);

    if (data != null) {
      AccessUser accessUser = AccessUser.fromJson(data);

      SharedPreferencesOperator.saveCurrentUser(
          jsonEncode(accessUser.toJson()));

      return true;
    } else {
      return false;
    }
  }




  static Future<bool> verifyRegistrationUser(
      BuildContext context,
    String name,
    String phone,
    String iin,
    bool partner,
    ClientType business,
  ) async {

    String url = AppEndpoints.registrationVerify;

    Map<String, dynamic> body = {
      'name': name,
      'mobile': AppFormatter.formatPhoneNumber(phone),
      'bin_iin': iin,
      'partner': partner,
      'client_type': business.toString().split('.').last
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, false,  body: body, RequestTypeEnum.post);

    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> registrationUser(
      BuildContext context,
      String name,
      String phone,
      String email,
      String iin,
      bool partner,
      String business,
      ) async {

    String url = AppEndpoints.registrationClient;

    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'mobile': AppFormatter.formatPhoneNumber(phone),
      'bin_iin': iin,
      'partner': partner,
      'client_type': business
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, false,  body: body, RequestTypeEnum.post);

    if (data != null) {
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> registrationUserByProvider(
      BuildContext context,
      String name,
      String phone,
      String iin,
      bool partner,
      String business,
      String code,
      String type,
      String platform,
      ) async {

    String url = AppEndpoints.registrationClient;

    Map<String, dynamic> body = {
      'name': name,
      "auth_code": code,
      "provider_type": type,
      "platform": platform,
      'mobile': AppFormatter.formatPhoneNumber(phone),
      'bin_iin': iin,
      'partner': partner,
      'client_type': business
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, false, body:body, RequestTypeEnum.post);

    if (data != null) {

      AccessUser accessUser = AccessUser.fromJson(data);

      SharedPreferencesOperator.saveCurrentUser(
          jsonEncode(accessUser.toJson()));

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> recoverPassword(BuildContext context,String email) async {
    String url = AppEndpoints.recoverPassword;

    Map<String, dynamic> body = { 'email': email,};

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, false, body:  body, RequestTypeEnum.post);

    return true;
  }


  static Future<bool> resetPassword(BuildContext context, String currentPassword, String newPassword, String confirmPassword) async {

    String url = AppEndpoints.resetPassword;

    Map<String, dynamic> body = {
      "old_password": currentPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body, RequestTypeEnum.post);

    return true;
  }

  static Future<bool> refreshToken(BuildContext context, String? token) async {

    String url = AppEndpoints.refreshToken;

    Map<String, dynamic> parameters = { 'token': token,};

    AccessUser? userInMemory = await SharedPreferencesOperator.getCurrentUser();

    SharedPreferencesOperator.clearCurrentUser();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, false,parameters: parameters, RequestTypeEnum.post);

    if (data != null) {
      AccessUser accessUser = AccessUser.fromJson(data);

      if(userInMemory != null){
        userInMemory.refreshToken = accessUser.refreshToken;
        userInMemory.accessToken = accessUser.accessToken;

        SharedPreferencesOperator.saveCurrentUser(
            jsonEncode(userInMemory.toJson()));

        return true;
      }else{
        return false;
      }

    } else {
      return false;
    }
  }

  static Future<String?>  getAuthProvider(BuildContext context, String providerType, String platform) async {

    String url = AppEndpoints.getAuthProvider;

    Map<String, dynamic> body = {
      "provider_type": providerType,
      "platform": platform
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, false, body: body, RequestTypeEnum.post, needAppCode: true);

    if(data!= null){
      return data['client_id'];
    }else {
      return null;
    }

  }

  static Future<User?> getMe(BuildContext context) async {

    String url = AppEndpoints.getMe;

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get);

    if(data!= null){
      return User.fromJson(data);
    }else {
      return null;
    }

  }


  static Future<bool> updateUser(BuildContext context, User user) async {

    String url = AppEndpoints.updateUser;

    Map<String, dynamic> body = user.toJson();

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, body: body,RequestTypeEnum.put);

    if(data!= null){
      return true;
    }else {
      return false;
    }

  }

}


enum ClientType{
  BUSINESS, INDIVIDUAL
}
