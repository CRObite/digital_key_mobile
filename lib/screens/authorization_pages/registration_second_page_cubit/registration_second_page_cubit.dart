

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../config/app_endpoints.dart';
import '../../../data/repository/auth_repository.dart';

part 'registration_second_page_state.dart';

class RegistrationSecondPageCubit extends Cubit<RegistrationSecondPageState> {
  RegistrationSecondPageCubit() : super(RegistrationSecondPageInitial());

  Future<void> registrationUser(String name,String phone,String email, String iin, bool partner, String business) async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.registrationVerify}';
      bool value = await AuthRepository.registrationUser(url, name, phone, email, iin, partner, business);
      if(value){
        emit(RegistrationSecondPageSuccess());
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
