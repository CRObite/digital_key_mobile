

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/repository/auth_repository.dart';
import 'package:web_com/utils/custom_exeption.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());

  Future<void> loginUser(String login,String password) async {

    try{
      String url = '${AppEndpoints.address}${AppEndpoints.login}';
      bool value = await AuthRepository.loginUser(url, login, password);
      if(value){
        emit(LoginPageSuccess());
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        print(exception.message);
        emit(LoginPageError(errorText: exception.message));
      }
    }
  }

}
