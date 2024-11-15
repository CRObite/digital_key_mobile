

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/repository/auth_repository.dart';
import 'package:web_com/utils/custom_exeption.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());

  Future<void> loginUser(BuildContext context,String login,String password) async {

    try{

      bool value = await AuthRepository.loginUser(context, login, password);
      if(value){
        emit(LoginPageSuccess());
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        print(exception.message);
        emit(LoginPageError(errorText: exception.message));
      }else{
        rethrow;
      }
    }
  }

  String generateCodeChallenge(String codeVerifier) {
    // Преобразуем code_verifier в байты с кодировкой US-ASCII
    List<int> bytes = ascii.encode(codeVerifier);

    // Создаем объект для хэширования с использованием алгоритма SHA-256
    Digest digest = sha256.convert(bytes);

    // Кодируем хэш в формате Base64 URL Safe и возвращаем результат
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  Future<void> startAuth(BuildContext context,String type) async {

    const callbackUrlScheme = 'com.digitalkey.dkmobile';


    String? clientId = '';
    if(Platform.isAndroid){
      clientId = await AuthRepository.getAuthProvider(context,type, 'ANDROID');
    }else if(Platform.isIOS){
      clientId = await AuthRepository.getAuthProvider(context,type, 'IOS');
    }

    if(clientId!= null && clientId.isNotEmpty){


      if(type == 'GOOGLE'){
        String codeVerifier = "YkcRHWRJIOnCMvvG0ZPKmcSEx-M9k2d2tFkUjX-b_x_N3PBqZTkHqdlISKz6PvxNxnYxfKcint_ZdurqG-ydWA";
        String codeChallenge = generateCodeChallenge(codeVerifier);

        print(codeChallenge);


        print('https://accounts.google.com/o/oauth2/v2/auth?scope=email profile&response_type=code&redirect_uri=$callbackUrlScheme:/&client_id=$clientId&code_challenge=$codeChallenge');
        final result = await FlutterWebAuth2.authenticate(url: 'https://accounts.google.com/o/oauth2/v2/auth?scope=email profile&response_type=code&redirect_uri=$callbackUrlScheme:/&client_id=$clientId&code_challenge=$codeChallenge', callbackUrlScheme: callbackUrlScheme,);
        final String? code = Uri.parse(result).queryParameters['code'];
        print(code);

        if(code!= null){
          loginUserByProvider(context,code, type, codeChallenge);
        }
      }else if(type == 'YANDEX'){


        final result = await FlutterWebAuth2.authenticate(
            url: 'https://oauth.yandex.ru/authorize?response_type=code&client_id=$clientId&redirect_uri=$callbackUrlScheme:/',
            callbackUrlScheme: callbackUrlScheme
        );
        print(result);
        final String? code = Uri.parse(result).queryParameters['code'];
        print(code);

        if(code!= null){
          loginUserByProvider(context,code, type, null);
        }
      }

    }
  }


  Future<void> loginUserByProvider(BuildContext context,String code,String type, String? codeChallenge) async {

    try{

      bool value = false;
      if(Platform.isAndroid){
        value = await AuthRepository.loginUserByProvider(context, code,codeChallenge, type, 'ANDROID');
      }else if(Platform.isIOS){
        value = await AuthRepository.loginUserByProvider(context, code,codeChallenge, type, 'IOS');
      }

      print(value);
      if(value){
        emit(LoginPageSuccess());
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        print(exception.message);
        emit(LoginPageError(errorText: exception.message));
      }else{
        rethrow;
      }
    }
  }



}
