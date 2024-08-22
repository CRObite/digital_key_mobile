

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_endpoints.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../utils/custom_exeption.dart';

part 'registration_page_state.dart';

class RegistrationPageCubit extends Cubit<RegistrationPageState> {
  RegistrationPageCubit() : super(RegistrationPageInitial());


  Future<void> registrationUser(String name,String phone, String iin, bool partner, ClientType business) async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.registrationVerify}';
      bool value = await AuthRepository.verifyRegistrationUser(url, name, phone, iin, partner, business);
      if(value){
        emit(RegistrationPageSuccess());
      }

    }catch(e){
      if(e is DioException){
        emit(RegistrationPageError(
          e.response!.data['field_errors'],
          e.response!.data['detail'],
        ));
      }
    }
  }



}
