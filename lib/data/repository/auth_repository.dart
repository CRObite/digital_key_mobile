import 'dart:convert';

import 'package:web_com/config/app_formatter.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/domain/access_user.dart';

import '../../domain/user.dart';
import 'dio_helper.dart';

class AuthRepository {

  static Future<bool> loginUser(
      String url, String login, String password) async {
    Map<String, dynamic> body = {'login': login, 'password': password};
    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

    if (data != null) {
      AccessUser accessUser = AccessUser.fromJson(data);

      SharedPreferencesOperator.saveCurrentUser(
          jsonEncode(accessUser.toJson()));

      return true;
    } else {
      return false;
    }
  }


  static Future<bool> loginUserByProvider(
      String url, String code , String codeChallenge,String type, String platform) async {

    Map<String, dynamic> body = {
      "auth_code": code,
      "provider_type": type,
      "platform": platform,
      "code_challenge": codeChallenge
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

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
    String url,
    String name,
    String phone,
    String iin,
    bool partner,
    ClientType business,
  ) async {
    Map<String, dynamic> body = {
      'name': name,
      'mobile': AppFormatter.formatPhoneNumber(phone),
      'bin_iin': iin,
      'partner': partner,
      'client_type': business.toString().split('.').last
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> registrationUser(
      String url,
      String name,
      String phone,
      String email,
      String iin,
      bool partner,
      String business,
      ) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'mobile': AppFormatter.formatPhoneNumber(phone),
      'bin_iin': iin,
      'partner': partner,
      'client_type': business
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

    if (data != null) {
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> registrationUserByProvider(
      String url,
      String name,
      String phone,
      String iin,
      bool partner,
      String business,
      String code,
      String type,
      String platform,
      ) async {
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
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

    if (data != null) {

      AccessUser accessUser = AccessUser.fromJson(data);

      SharedPreferencesOperator.saveCurrentUser(
          jsonEncode(accessUser.toJson()));

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> resetPassword(String url, String email) async {
    Map<String, dynamic> body = { 'email': email,};

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

    return true;
  }

  static Future<bool> refreshToken(String url, String? token) async {

    Map<String, dynamic> parameters = { 'token': token,};

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, parameters, null, RequestTypeEnum.post);

    if (data != null) {
      AccessUser accessUser = AccessUser.fromJson(data);

      SharedPreferencesOperator.saveCurrentUser(
          jsonEncode(accessUser.toJson()));

      return true;
    } else {
      return false;
    }
  }

  static Future<String?>  getAuthProvider(String url, String providerType, String platform) async {

    Map<String, dynamic> body = {
      "provider_type": providerType,
      "platform": platform
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post, needAppCode: true);

    if(data!= null){
      return data['client_id'];
    }else {
      return null;
    }

  }

  static Future<User?> getMe(String url) async {

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, true, null, null, RequestTypeEnum.get);

    if(data!= null){
      return User.fromJson(data);
    }else {
      return null;
    }

  }


}


enum ClientType{
  BUSINESS, INDIVIDUAL
}
