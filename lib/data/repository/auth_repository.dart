import 'dart:convert';

import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/domain/access_user.dart';

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
      'mobile': phone,
      'bin_iin': iin,
      'partner': partner,
      'business': business
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
      ClientType business,
      ) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'mobile': phone,
      'bin_iin': iin,
      'partner': partner,
      'business': business
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, false, null, body, RequestTypeEnum.post);

    if (data != null) {
      return true;
    } else {
      return false;
    }
  }
}


enum ClientType{
  BUSINESS, INDIVIDUAL
}
