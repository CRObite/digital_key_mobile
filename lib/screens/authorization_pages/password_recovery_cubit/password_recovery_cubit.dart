

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_endpoints.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../utils/custom_exeption.dart';

part 'password_recovery_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  PasswordRecoveryCubit() : super(PasswordRecoveryInitial());

  Future<void> recoverPassword(BuildContext context,String email) async {

    try{
      String url = '${AppEndpoints.address}${AppEndpoints.recoverPassword}';
      bool value = await AuthRepository.recoverPassword(context,url,email);
      if(value){
        emit(PasswordRecoverySuccess());
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        print(exception.message);
        emit(PasswordRecoveryError(errorText: exception.message));
      }
    }
  }
}
