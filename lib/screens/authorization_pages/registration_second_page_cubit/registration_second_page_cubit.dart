

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../config/app_endpoints.dart';
import '../../../data/repository/auth_repository.dart';

part 'registration_second_page_state.dart';

class RegistrationSecondPageCubit extends Cubit<RegistrationSecondPageState> {
  RegistrationSecondPageCubit() : super(RegistrationSecondPageInitial());

  Future<void> registrationUser(String name,String phone,String email, String iin, bool partner, String business) async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.registrationClient}';
      bool value = await AuthRepository.registrationUser(url, name, phone, email, iin, partner, business);
      if(value){
        emit(RegistrationSecondPageSuccess(byProvider: false));
      }
    }catch(e){
      if(e is DioException){

        CustomException exception = CustomException.fromDioException(e);

        emit(RegistrationSecondPageError(
          errorText: exception.message,
        ));
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

  Future<void> startAuth(String type, String name,String phone, String iin, bool partner, String business) async {

    const callbackUrlScheme = 'com.digitalkey.dkmobile';

    String url = '${AppEndpoints.address}${AppEndpoints.getAuthProvider}';
    String? clientId = '';
    if(Platform.isAndroid){
      clientId = await AuthRepository.getAuthProvider(url, type, 'ANDROID');
    }else if(Platform.isIOS){
      clientId = await AuthRepository.getAuthProvider(url, type, 'IOS');
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
          registrationUserByProvider(name, phone, iin, partner, business, code, type);
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
          registrationUserByProvider(name, phone, iin, partner, business, code, type);
        }
      }


    }
  }

  Future<void> registrationUserByProvider(String name,String phone, String iin, bool partner, String business,code, type) async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.registrationClient}';

      bool value = false;
      if(Platform.isAndroid){
        value = await AuthRepository.registrationUserByProvider(url, name, phone, iin, partner, business, code, type, 'ANDROID');
      }else if(Platform.isIOS){
        value = await AuthRepository.registrationUserByProvider(url, name, phone, iin, partner, business, code, type, 'IOS');
      }

      if(value){
        emit(RegistrationSecondPageSuccess(byProvider: true));
      }
    }catch(e){
      if(e is DioException){

        CustomException exception = CustomException.fromDioException(e);

        emit(RegistrationSecondPageError(
          errorText: exception.message,
        ));
      }
    }
  }
}
